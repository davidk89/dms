import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { ConfigModule } from '@nestjs/config';
import { DepartmentUserService } from './department-user.service';
import { DepartmentUserController } from './department-user.controller';
import { DepartmentModule } from '../department/department.module';

@Module({
  imports: [ConfigModule, HttpModule, DepartmentModule],
  providers: [DepartmentUserService],
  controllers: [DepartmentUserController],
})
export class DepartmentUserModule {}
