import { IsDate, IsString, IsUUID } from 'class-validator';
export class DepartmentDto {
  @IsString()
  @IsUUID()
  id: string;

  @IsString()
  name: string;

  @IsDate()
  createdAt: Date;

  @IsDate()
  updatedAt: Date;
}
