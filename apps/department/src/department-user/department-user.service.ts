import { Injectable, NotFoundException } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { DepartmentService } from '../department/department.service';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { DepartmentUser } from './entities/department-user.entity';
import { httpErrorHandling } from '@dms/common';

@Injectable()
export class DepartmentUserService {
  constructor(
    private readonly configService: ConfigService,
    private readonly httpService: HttpService,
    private readonly departmentService: DepartmentService,
    @InjectRepository(DepartmentUser)
    private departmentUserRepository: Repository<DepartmentUser>,
  ) {}

  async findAll(departmentId: string) {
    const department = await this.departmentService.findOne(departmentId);

    return await this.departmentUserRepository.find({
      relations: ['department'],
      where: {
        department: {
          id: department.id,
        },
      },
    });
  }

  async findOne(departmentId: string, userId: string) {
    const department = await this.departmentService.findOne(departmentId);

    const departmentUser = await this.departmentUserRepository.findOne({
      relations: ['department'],
      where: {
        department: { id: department.id },
        userId,
      },
    });

    if (!departmentUser) {
      throw new NotFoundException(
        `User UUID ${userId} not found in given department`,
      );
    }

    return departmentUser;
  }

  async assign(departmentId: string, userId: string) {
    const department = await this.departmentService.findOne(departmentId);

    const departmentUser = await this.departmentUserRepository.findOne({
      relations: ['department'],
      where: {
        userId,
      },
    });

    if (departmentUser) {
      departmentUser.department = await this.departmentService.findOne(
        departmentId,
      );
      return await this.departmentUserRepository.save(departmentUser);
    }

    const departmentUserAssign = new DepartmentUser();
    departmentUserAssign.department = department;
    departmentUserAssign.userId = userId;
    return await this.departmentUserRepository.save(departmentUserAssign);
  }

  async remove(departmentId: string, userId: string) {
    try {
      const department = await this.departmentService.findOne(departmentId);

      const departmentUser = await this.departmentUserRepository.findOne({
        relations: ['department'],
        where: {
          department: { id: department.id },
          userId,
        },
      });

      if (departmentUser) {
        await this.departmentUserRepository.remove(departmentUser);
      }

      return true;
    } catch (e) {
      console.log(e);
      httpErrorHandling(e);
    }
  }

  async removeAll(departmentId: string) {
    try {
      const department = await this.departmentService.findOne(departmentId);
      await this.departmentUserRepository.delete({ department });
    } catch (e) {
      httpErrorHandling(e);
    }
  }
}
