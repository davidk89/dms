import { Module } from '@nestjs/common';
import { DepartmentModule } from './department/department.module';
import { ConfigModule } from '@nestjs/config';
import { DepartmentUserModule } from './department-user/department-user.module';
import { APP_GUARD } from '@nestjs/core';
import { ThrottlerGuard, ThrottlerModule } from '@nestjs/throttler';

@Module({
  imports: [
    ConfigModule.forRoot(),
    ThrottlerModule.forRoot({
      ttl: 10,
      limit: 5,
    }),
    DepartmentModule,
    DepartmentUserModule,
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
  ],
})
export class ApiModule {}
