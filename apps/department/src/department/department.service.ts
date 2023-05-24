import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Department } from './entities/department.entity';
import { Repository } from 'typeorm';
import {
  CreateDepartmentDto,
  DepartmentDto,
  UpdateDepartmentDto,
} from '@dms/dto';

@Injectable()
export class DepartmentService {
  constructor(
    @InjectRepository(Department)
    private departmentsRepository: Repository<Department>,
  ) {}

  async findAll(): Promise<DepartmentDto[]> {
    return await this.departmentsRepository.find();
  }

  async findOne(id: string): Promise<DepartmentDto> {
    const department = await this.departmentsRepository.findOneBy({ id });
    if (!department) {
      throw new NotFoundException(`Department not found: ${id}`);
    }

    return department;
  }

  async create(
    createDepartmentDto: CreateDepartmentDto,
  ): Promise<DepartmentDto> {
    const departmentByName = await this.departmentsRepository.findOneBy({
      name: createDepartmentDto.name,
    });

    if (departmentByName) {
      throw new ConflictException(
        `Department already exists: ${createDepartmentDto.name}`,
      );
    }

    const department = new Department();
    department.name = createDepartmentDto.name;
    return await this.departmentsRepository.save(department);
  }

  async update(
    id: string,
    updateDepartmentDto: UpdateDepartmentDto,
  ): Promise<DepartmentDto> {
    const department = await this.findOne(id);

    department.name = updateDepartmentDto.name;
    return await this.departmentsRepository.save(department);
  }

  async remove(id: string) {
    const department = await this.findOne(id);
    await this.departmentsRepository.remove(department);
  }
}
