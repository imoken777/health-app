import controller from '$/api/tasks/di/controller';
import type { UserId } from '$/commonTypesWithClient/ids';
import type { UserModel } from '$/commonTypesWithClient/models';
import { taskIdParser } from '$/service/idParsers';
import type { Task } from '@prisma/client';
import fastify from 'fastify';
import { expect, test } from 'vitest';
import { apiClient, testUser } from './apiClient';

test('API接続確認', async () => {
  const res = await apiClient.health.$get();

  expect(res.server).toEqual('ok');
  expect(res.db).toEqual('ok');
});

test('認証確認', async () => {
  const res = await apiClient.me.$get();

  expect(res.email).toBe(testUser.email);
});

test('userProfile確認', async () => {
  const userProfileMock: { birthday: number; gender: 'Male' } = {
    birthday: 0,
    gender: 'Male',
  };
  const res1 = await apiClient.userProfile.post({ body: userProfileMock });
  expect(res1.status).toBe(200);
  const res2 = await apiClient.userProfile.$get();
  expect(res2?.birthday).toBe(userProfileMock.birthday);
  expect(res2?.gender).toBe(userProfileMock.gender);
});

test('依存性注入', async () => {
  const res1 = await controller(fastify()).get({
    user: { id: 'dummy-userId' } as UserModel,
  });

  expect(res1.body).toHaveLength(2);

  const mockedFindManyTask = async (userId: UserId): Promise<Task[]> => [
    {
      id: taskIdParser.parse('foo'),
      userId,
      label: 'baz',
      done: false,
      createdAt: new Date(),
    },
  ];

  const res2 = await controller
    .inject({ findManyTask: mockedFindManyTask })(fastify())
    .get({
      user: { id: 'dummy-userId' } as UserModel,
    });

  expect(res2.body).toHaveLength(1);
});
