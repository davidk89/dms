import { Module } from '@nestjs/common';
import { KeycloakService } from './keycloak.service';
import { ConfigModule } from '@nestjs/config';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [ConfigModule, HttpModule],
  providers: [KeycloakService],
  exports: [KeycloakService],
})
export class KeycloakModule {}
