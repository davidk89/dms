import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import KcAdminClient from '@keycloak/keycloak-admin-client';
import { ConfigService } from '@nestjs/config';
import { CreateUserDto } from '../user/dto/CreateUser.dto';
import { FindUsersDto } from '../user/dto/FindUsers.dto';
import { HttpService } from '@nestjs/axios';
import { lastValueFrom } from 'rxjs';
import { UpdateUserDto } from '../user/dto/UpdateUser.dto';

@Injectable()
export class KeycloakService {
  constructor(
    private readonly configService: ConfigService,
    private readonly httpService: HttpService,
  ) {}
  async getAdminClient() {
    const adminClient = new KcAdminClient({
      baseUrl: this.configService.get('KEYCLOAK_HOST'),
      realmName: this.configService.get('KEYCLOAK_REALM'),
    });

    await adminClient.auth({
      grantType: 'client_credentials',
      clientId: this.configService.get('KEYCLOAK_CLIENT_ID') as string,
      clientSecret: this.configService.get('KEYCLOAK_CLIENT_SECRET'),
    });

    return adminClient;
  }

  async findUsers(query: FindUsersDto) {
    const client = await this.getAdminClient();

    const keycloakUrl = this.configService.get('KEYCLOAK_HOST');
    const realm = this.configService.get('KEYCLOAK_REALM');

    const request = this.httpService.get(
      `${keycloakUrl}/admin/realms/${realm}/users?q=departmentId:${query.departmentId}&max=999999`,
      {
        headers: {
          Authorization: `Bearer ${client.accessToken}`,
        },
      },
    );

    const response = await lastValueFrom(request);
    return response.data;
  }

  async findUser(id: string) {
    const client = await this.getAdminClient();

    const user = await client.users.findOne({
      id,
    });

    if (!user) {
      throw new NotFoundException(`User not found: ${id}`);
    }

    return user;
  }

  async createUser(createUserDto: CreateUserDto) {
    const client = await this.getAdminClient();

    const users = await client.users.find({
      email: createUserDto.email.toLowerCase(),
      exact: true,
    });

    if (users.length) {
      throw new ConflictException('Given e-mail address is not available');
    }

    return await client.users.create({
      username: createUserDto.email,
      email: createUserDto.email.toLowerCase(),
      firstName: createUserDto.firstName,
      lastName: createUserDto.lastName,
      emailVerified: true,
      enabled: true,
      attributes: {
        departmentId: createUserDto.departmentId,
      },
      credentials: [
        {
          type: 'password',
          value: createUserDto.password,
        },
      ],
    });
  }

  async updateUser(id: string, updateUserDto: UpdateUserDto) {
    const client = await this.getAdminClient();

    const user = await this.findUser(id);

    return await client.users.update(
      { id: user.id },
      {
        email: updateUserDto.email?.toLowerCase(),
        firstName: updateUserDto.firstName,
        lastName: updateUserDto.lastName,
        attributes: updateUserDto.departmentId
          ? {
              departmentId: updateUserDto.departmentId,
            }
          : undefined,
      },
    );
  }

  async removeUser(id: string) {
    const user = await this.findUser(id);
    const client = await this.getAdminClient();
    return await client.users.del({ id: user.id });
  }
}
