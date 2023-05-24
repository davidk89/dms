import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { ApiModule } from '../src/api.module';
import * as assert from 'assert';

describe('DepartmentController (e2e)', () => {
  let app: INestApplication;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [ApiModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  const departmentName = `Department ${Date.now()}`;
  let departmentId;

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

  it('/departments (GET)', async () => {
    const response = await request(app.getHttpServer()).get('/departments');
    expect(response.body.length).toBeGreaterThan(0);
  });

  it('/departments (POST) validate', () => {
    return request(app.getHttpServer())
      .post('/departments')
      .send({ name: departmentName })
      .expect(409);
  });

  it('/departments/{id} (GET)', () => {
    return request(app.getHttpServer())
      .get(`/departments/${departmentId}`)
      .expect(200);
  });

  it('/departments/{id} (PATCH)', async () => {
    const newDepartmentName = `Department ${Date.now()}`;
    const response = await request(app.getHttpServer())
      .patch(`/departments/${departmentId}`)
      .send({
        name: newDepartmentName,
      });
    expect(response.body.name).toEqual(newDepartmentName);
  });

  it('/departments/{id} (DELETE)', async () => {
    await request(app.getHttpServer())
      .delete(`/departments/${departmentId}`)
      .expect(200);
  });

  it('/departments/{id} (GET) 404', () => {
    return request(app.getHttpServer())
      .get(`/departments/${departmentId}`)
      .expect(404);
  });
});
