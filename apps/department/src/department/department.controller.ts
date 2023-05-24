import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { DepartmentService } from './department.service';
import { ApiTags } from '@nestjs/swagger';
import {
  CreateDepartmentDto,
  DepartmentDto,
  FindDepartmentDto,
  UpdateDepartmentDto,
} from '@dms/dto';

@ApiTags('Departments')
@Controller('departments')
export class DepartmentController {
  constructor(private readonly departmentService: DepartmentService) {}

  @Get()
  async findAll(): Promise<DepartmentDto[]> {
    return await this.departmentService.findAll();
  }

  @Get(':id')
  async findOne(
    @Param() findDepartmentDto: FindDepartmentDto,
  ): Promise<DepartmentDto> {
    return await this.departmentService.findOne(findDepartmentDto.id);
  }

  @Post()
  async create(
    @Body() createDepartmentDto: CreateDepartmentDto,
  ): Promise<DepartmentDto> {
    return await this.departmentService.create(createDepartmentDto);
  }

  @Patch(':id')
  async update(
    @Param() findDepartmentDto: FindDepartmentDto,
    @Body() updateDepartmentDto: UpdateDepartmentDto,
  ): Promise<DepartmentDto> {
    return await this.departmentService.update(
      findDepartmentDto.id,
      updateDepartmentDto,
    );
  }

  @Delete(':id')
  async remove(@Param() findDepartmentDto: FindDepartmentDto) {
    return await this.departmentService.remove(findDepartmentDto.id);
  }
}
