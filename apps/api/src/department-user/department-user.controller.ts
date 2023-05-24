import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import {
  CreateDepartmentUserDto,
  FindDepartmentDto,
  FindDepartmentUserDto,
  UpdateDepartmentUserDto,
} from '@dms/dto';
import { DepartmentUserService } from './department-user.service';
import { User } from '@dms/types';

@ApiTags('Department users')
@Controller('departments')
export class DepartmentUserController {
  constructor(private readonly departmentUserService: DepartmentUserService) {}

  @Get(':id/users')
  async findUsers(
    @Param() findDepartmentDto: FindDepartmentDto,
  ): Promise<User[]> {
    return await this.departmentUserService.findAll(findDepartmentDto.id);
  }

  @Get(':id/users/:userId')
  async findUser(
    @Param() findDepartmentUserDto: FindDepartmentUserDto,
  ): Promise<User> {
    return await this.departmentUserService.findOne(
      findDepartmentUserDto.id,
      findDepartmentUserDto.userId,
    );
  }

  @Post(':id/users')
  async create(
    @Param() findDepartmentDto: FindDepartmentDto,
    @Body() createDepartmentUserDto: CreateDepartmentUserDto,
  ): Promise<User> {
    return await this.departmentUserService.create(
      findDepartmentDto.id,
      createDepartmentUserDto,
    );
  }

  @Patch(':id/users/:userId')
  async update(
    @Param() findDepartmentUserDto: FindDepartmentUserDto,
    @Body() updateDepartmentUserDto: UpdateDepartmentUserDto,
  ): Promise<User> {
    return await this.departmentUserService.update(
      findDepartmentUserDto.id,
      findDepartmentUserDto.userId,
      updateDepartmentUserDto,
    );
  }

  @Delete(':id/users/:userId')
  async remove(@Param() findDepartmentUserDto: FindDepartmentUserDto) {
    return await this.departmentUserService.remove(
      findDepartmentUserDto.id,
      findDepartmentUserDto.userId,
    );
  }
}
