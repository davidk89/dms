import { IsNotEmpty, IsUUID } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
export class FindDepartmentDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsUUID()
  id: string;
}
