import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { lastValueFrom } from 'rxjs';
import { httpErrorHandling } from '@dms/common';
import {
  CreateDepartmentDto,
  DepartmentDto,
  DepartmentUserDto,
  UpdateDepartmentDto,
} from '@dms/dto';

@Injectable()
export class DepartmentService {
  constructor(
    private readonly httpService: HttpService,
    private readonly configService: ConfigService,
  ) {}

  async findAll(): Promise<DepartmentDto[]> {
    try {
      const departmentServiceHost = this.configService.get(
        'DEPARTMENT_SERVICE_HOST',
      );

      const request = this.httpService.get(
        `${departmentServiceHost}/api/departments`,
      );

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      console.log(e);
      httpErrorHandling(e);
    }
  }

  async findOne(id: string): Promise<DepartmentDto> {
    try {
      const departmentServiceHost = this.configService.get(
        'DEPARTMENT_SERVICE_HOST',
      );

      const request = this.httpService.get(
        `${departmentServiceHost}/api/departments/${id}`,
      );

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async findUsers(id: string): Promise<DepartmentUserDto[]> {
    try {
      const departmentServiceHost = this.configService.get(
        'DEPARTMENT_SERVICE_HOST',
      );

      const request = this.httpService.get(
        `${departmentServiceHost}/api/departments/${id}/users`,
      );

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async findUserAssignment(
    departmentId: string,
    id: string,
  ): Promise<DepartmentUserDto> {
    try {
      const departmentServiceHost = this.configService.get(
        'DEPARTMENT_SERVICE_HOST',
      );

      const request = this.httpService.get(
        `${departmentServiceHost}/api/departments/${departmentId}/users/${id}`,
      );

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async create(
    createDepartmentDto: CreateDepartmentDto,
  ): Promise<DepartmentDto> {
    try {
      const departmentServiceHost = this.configService.get(
        'DEPARTMENT_SERVICE_HOST',
      );

      const request = this.httpService.post(
        `${departmentServiceHost}/api/departments/`,
        createDepartmentDto,
      );

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async update(
    id: string,
    updateDepartmentDto: UpdateDepartmentDto,
  ): Promise<DepartmentDto> {
    try {
      const departmentServiceHost = this.configService.get(
        'DEPARTMENT_SERVICE_HOST',
      );

      const request = this.httpService.patch(
        `${departmentServiceHost}/api/departments/${id}`,
        updateDepartmentDto,
      );

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async remove(id: string): Promise<void> {
    try {
      const departmentServiceHost = this.configService.get(
        'DEPARTMENT_SERVICE_HOST',
      );

      await this.removeDepartmentUsers(id);

      const request = this.httpService.delete(
        `${departmentServiceHost}/api/departments/${id}`,
      );

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }

  async removeDepartmentUsers(id: string) {
    try {
      const departmentServiceHost = this.configService.get(
        'DEPARTMENT_SERVICE_HOST',
      );

      const request = this.httpService.delete(
        `${departmentServiceHost}/api/departments/${id}/users`,
      );

      const response = await lastValueFrom(request);
      return response.data;
    } catch (e) {
      httpErrorHandling(e);
    }
  }
}
