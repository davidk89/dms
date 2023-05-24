import { IsUUID } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class FindUsersDto {
  @ApiProperty()
  @IsUUID()
  departmentId: string;
}
