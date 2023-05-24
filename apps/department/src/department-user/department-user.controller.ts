import { Controller, Delete, Get, Param } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { DepartmentUserService } from './department-user.service';
import { FindDepartmentDto, FindDepartmentUserDto } from '@dms/dto';
import { MessagePattern, Payload } from '@nestjs/microservices';
import { AssignUserToDepartmentDto } from './dto/AssignUserToDepartment.dto';
import { UnassignUserFromDepartmentDto } from './dto/UnassignUserFromDepartment.dto';

@ApiTags('Department users')
@Controller('departments')
export class DepartmentUserController {
  constructor(private readonly departmentUserService: DepartmentUserService) {}

  @Get(':id/users')
  async findAll(@Param() findDepartmentDto: FindDepartmentDto) {
    return await this.departmentUserService.findAll(findDepartmentDto.id);
  }

  @Get(':id/users/:userId')
  async findOne(@Param() findDepartmentUserDto: FindDepartmentUserDto) {
    return await this.departmentUserService.findOne(
      findDepartmentUserDto.id,
      findDepartmentUserDto.userId,
    );
  }

  @MessagePattern({ cmd: 'assign-department' })
  async assign(
    @Payload() assignUserToDepartmentDto: AssignUserToDepartmentDto,
  ) {
    return await this.departmentUserService.assign(
      assignUserToDepartmentDto.departmentId,
      assignUserToDepartmentDto.userId,
    );
  }

  @MessagePattern({ cmd: 'unassign-department' })
  async remove(
    @Payload() unassignUserFromDepartmentDto: UnassignUserFromDepartmentDto,
  ) {
    return await this.departmentUserService.remove(
      unassignUserFromDepartmentDto.departmentId,
      unassignUserFromDepartmentDto.userId,
    );
  }

  @Delete(':id/users')
  async removeAll(@Param() findDepartmentDto: FindDepartmentDto) {
    return await this.departmentUserService.removeAll(findDepartmentDto.id);
  }
}
