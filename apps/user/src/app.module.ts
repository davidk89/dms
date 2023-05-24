import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { KeycloakModule } from './keycloak/keycloak.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [ConfigModule.forRoot(), UserModule, KeycloakModule],
})
export class AppModule {}
