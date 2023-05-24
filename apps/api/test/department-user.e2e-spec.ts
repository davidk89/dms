import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { ApiModule } from '../src/api.module';
import * as assert from 'assert';

describe('DepartmentUserController (e2e)', () => {
  let app: INestApplication;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [ApiModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  const departmentName = `Department ${Date.now()}`;
  const userEmail = `user${Date.now()}@example.com`;
  let departmentId;
  let userId;

  console.log('uu', userEmail);

  it('/departments (POST)', () => {
    return request(app.getHttpServer())
      .post('/departments')
      .send({ name: departmentName })
      .expect(201)
      .then((response) => {
        assert(response.body.name, departmentName);
        departmentId = response.body.id;
      });
  });

  it(`/departments/{id}/user (POST)`, () => {
    return request(app.getHttpServer())
      .post(`/departments/${departmentId}/users`)
      .send({ email: userEmail, firstName: 'Test', lastName: 'Test' })
      .expect(201)
      .then((response) => {
        assert(response.body.email, userEmail);
        userId = response.body.id;
      });
  });

  it(`/departments/{id}/user (POST) validate`, () => {
    return request(app.getHttpServer())
      .post(`/departments/${departmentId}/users`)
      .send({ email: userEmail, firstName: 'Test', lastName: 'Test' })
      .expect(409);
  });

  it(`/departments/{id}/user/{id} (GET)`, () => {
    return request(app.getHttpServer())
      .get(`/departments/${departmentId}/users/${userId}`)
      .expect(200)
      .then((response) => {
        assert(response.body.email, userEmail);
      });
  });

  it(`/departments/{id}/user (GET)`, async () => {
    const response = await request(app.getHttpServer()).get(
      `/departments/${departmentId}/users`,
    );
    expect(response.body.length).toBeGreaterThan(0);
  });

  it(`/departments/{id}/user/{id} (PATCH)`, async () => {
    const response = await request(app.getHttpServer())
      .patch(`/departments/${departmentId}/users/${userId}`)
      .send({ firstName: 'Test2', lastName: 'Test2' });
    expect(response.body.firstName).toEqual('Test2');
    expect(response.body.lastName).toEqual('Test2');
  });

  it(`/departments/{id}/user/{id} (DELETE)`, () => {
    return request(app.getHttpServer())
      .delete(`/departments/${departmentId}/users/${userId}`)
      .expect(200);
  });

  it(`/departments/{id}/user/{id} GET 404`, () => {
    return request(app.getHttpServer())
      .get(`/departments/${departmentId}/users/${userId}`)
      .expect(404);
  });
});
