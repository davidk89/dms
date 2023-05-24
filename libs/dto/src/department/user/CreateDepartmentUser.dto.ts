import { IsEmail, IsNotEmpty, IsString, Length } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
export class CreateDepartmentUserDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsEmail()
  @Length(2, 50)
  email: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  @Length(2, 50)
  firstName: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  @Length(2, 50)
  lastName: string;
}
