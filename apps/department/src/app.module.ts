import { Module } from '@nestjs/common';
import { DepartmentModule } from './department/department.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Department } from './department/entities/department.entity';
import { DepartmentUserModule } from './department-user/department-user.module';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DepartmentUser } from './department-user/entities/department-user.entity';
import { ClientsModule, Transport } from '@nestjs/microservices';
@Module({
  imports: [
    ConfigModule.forRoot(),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get('DATABASE_HOST'),
        port: +configService.get<number>('DATABASE_PORT'),
        username: configService.get('DATABASE_USERNAME'),
        password: configService.get('DATABASE_PASSWORD'),
        database: configService.get('DATABASE_NAME'),
        schema: 'dms_departments',
        entities: [Department, DepartmentUser],
        synchronize: true,
      }),
      inject: [ConfigService],
    }),
    ClientsModule.registerAsync([
      {
        name: 'DEPARTMENT_SERVICE',
        imports: [ConfigModule],
        useFactory: (configService: ConfigService) => ({
          transport: Transport.RMQ,
          options: {
            urls: [`${configService.get('RABBITMQ_URL')}`],
            queue: `${configService.get('RABBITMQ_QUEUE')}`,
            queueOptions: {
              durable: false,
            },
            prefetchCount: 1,
          },
        }),
        inject: [ConfigService],
      },
    ]),
    DepartmentModule,
    DepartmentUserModule,
  ],
})
export class AppModule {}
