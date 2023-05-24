import { IsDate, IsObject, IsString, IsUUID } from 'class-validator';
import { DepartmentDto } from '@dms/dto/department';

export class DepartmentUserDto {
  @IsString()
  @IsUUID()
  id: string;

  @IsString()
  @IsUUID()
  userId: string;

  @IsDate()
  createdAt: Date;

  @IsDate()
  updatedAt: Date;

  @IsObject()
  department: DepartmentDto;
}
