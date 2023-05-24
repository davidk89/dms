import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { CreateDepartmentUserDto, UpdateDepartmentUserDto } from '@dms/dto';
import { lastValueFrom } from 'rxjs';
import { httpErrorHandling } from '@dms/common';
import { DepartmentService } from '../department/department.service';
import { randomUUID } from 'crypto';
import { User } from '@dms/types';

@Injectable()
export class DepartmentUserService {
  constructor(
    private readonly httpService: HttpService,
    private readonly configService: ConfigService,
    private readonly departmentService: DepartmentService,
  ) {}
  async findAll(departmentId: string): Promise<User[]> {
    try {
      const departmentUsers = await this.departmentService.findUsers(
        departmentId,
      );

      const userServiceHost = this.configService.get('USER_SERVICE_HOST');

      const users: Promise<User>[] = departmentUsers.map(
        async (departmentUser) => {
          const request = this.httpService.get(
            `${userServiceHost}/api/user/${departmentUser.userId}`,
          );
          const response = await lastValueFrom(request);
          return response.data;
        },
      );

      return Promise.all(users);
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async findOne(departmentId: string, id: string): Promise<User> {
    try {
      const departmentUser = await this.departmentService.findUserAssignment(
        departmentId,
        id,
      );

      const userServiceHost = this.configService.get('USER_SERVICE_HOST');
      const request = this.httpService.get(
        `${userServiceHost}/api/user/${departmentUser.userId}`,
      );
      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async create(
    departmentId: string,
    createDepartmentUserDto: CreateDepartmentUserDto,
  ): Promise<User> {
    const department = await this.departmentService.findOne(departmentId);

    const userServiceHost = this.configService.get('USER_SERVICE_HOST');

    try {
      const request = this.httpService.post(`${userServiceHost}/api/user`, {
        departmentId: department.id,
        email: createDepartmentUserDto.email,
        firstName: createDepartmentUserDto.firstName,
        lastName: createDepartmentUserDto.lastName,
        password: randomUUID(),
      });

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async update(
    departmentId: string,
    id: string,
    updateDepartmentUserDto: UpdateDepartmentUserDto,
  ): Promise<User> {
    try {
      const user = await this.findOne(departmentId, id);

      const userServiceHost = this.configService.get('USER_SERVICE_HOST');
      const request = this.httpService.patch(
        `${userServiceHost}/api/user/${user.id}`,
        {
          departmentId: updateDepartmentUserDto.departmentId,
          email: updateDepartmentUserDto.email,
          firstName: updateDepartmentUserDto.firstName,
          lastName: updateDepartmentUserDto.lastName,
        },
      );

      await lastValueFrom(request);

      if (updateDepartmentUserDto.departmentId) {
        departmentId = updateDepartmentUserDto.departmentId;
      }

      return await this.findOne(departmentId, id);
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async remove(departmentId: string, userId: string) {
    const userServiceHost = this.configService.get('USER_SERVICE_HOST');

    try {
      const userServiceRequest = this.httpService.delete(
        `${userServiceHost}/api/user/${userId}`,
      );

      const userServiceResponse = await lastValueFrom(userServiceRequest);
      return userServiceResponse.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }
}
