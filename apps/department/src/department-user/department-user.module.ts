import { Global, Module } from '@nestjs/common';
import { DepartmentUserService } from './department-user.service';
import { DepartmentUserController } from './department-user.controller';
import { HttpModule } from '@nestjs/axios';
import { ConfigModule } from '@nestjs/config';
import { DepartmentModule } from '../department/department.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DepartmentUser } from './entities/department-user.entity';
import { ClientsModule, Transport } from "@nestjs/microservices";

@Global()
@Module({
  imports: [
    ConfigModule,
    HttpModule,
    DepartmentModule,
    TypeOrmModule.forFeature([DepartmentUser]),
    ClientsModule.register([
      {
        name: 'DEPARTMENT_SERVICE',
        transport: Transport.RMQ,
        options: {
          urls: ['amqp://localhost:5672'],
          queue: 'dms_queue',
          queueOptions: {
            durable: false,
          },
          prefetchCount: 1,
        },
      },
    ]),
  ],
  providers: [DepartmentUserService],
  controllers: [DepartmentUserController],
})
export class DepartmentUserModule {}
