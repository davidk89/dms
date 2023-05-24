import { Inject, Injectable, NotFoundException } from "@nestjs/common";
import { CreateUserDto } from './dto/CreateUser.dto';
import { KeycloakService } from '../keycloak/keycloak.service';
import { FindUsersDto } from './dto/FindUsers.dto';
import { UpdateUserDto } from './dto/UpdateUser.dto';
import UserRepresentation from '@keycloak/keycloak-admin-client/lib/defs/userRepresentation';
import { ClientProxy } from '@nestjs/microservices';
import { lastValueFrom } from 'rxjs';

@Injectable()
export class UserService {
  constructor(
    @Inject('DEPARTMENT_SERVICE') private client: ClientProxy,
    private readonly keycloakService: KeycloakService,
  ) {}

  async findAll(query: FindUsersDto): Promise<UserRepresentation[]> {
    return await this.keycloakService.findUsers(query);
  }

  async findOne(id: string): Promise<UserRepresentation> {
    return await this.keycloakService.findUser(id);
  }

  async createUser(createUserDto: CreateUserDto) {
    const createdUser = await this.keycloakService.createUser(createUserDto);

    await lastValueFrom(
      this.client.send(
        { cmd: 'assign-department' },
        {
          departmentId: createUserDto.departmentId,
          userId: createdUser.id,
        },
      ),
    );
    return await this.keycloakService.findUser(createdUser.id);
  }

  async updateUser(id: string, updateUserDto: UpdateUserDto) {
    await this.keycloakService.updateUser(id, updateUserDto);

    if (updateUserDto.departmentId) {
      try {
        await lastValueFrom(
          this.client.send(
            { cmd: 'assign-department' },
            {
              departmentId: updateUserDto.departmentId,
              userId: id,
            },
          ),
        );
      } catch (e) {
        console.log(e);
      }
    }

    return await this.keycloakService.findUser(id);
  }

  async removeUser(id: string) {
    const user = await this.findOne(id);

    console.log('try', id);
    if (!user) {
      throw new NotFoundException(`User not found: ${id}`);
    }

    await lastValueFrom(
      this.client.send(
        { cmd: 'unassign-department' },
        {
          departmentId: user.attributes.departmentId[0],
          userId: user.id,
        },
      ),
    );

    return await this.keycloakService.removeUser(user.id);
  }
}
