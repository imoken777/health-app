import { userProfileRepo } from '$/repository/userProfileRepo';
import { UserProfileUseCase } from '$/useCase/userProfileUseCase';
import { Gender } from '@prisma/client';
import { z } from 'zod';
import { defineController } from './$relay';

export default defineController(() => ({
  get: async ({ user }) => ({
    status: 200,
    body: await userProfileRepo.getByUserId(user.id),
  }),
  post: {
    validators: {
      body: z.object({
        birthday: z.number(),
        gender: z.nativeEnum(Gender),
      }),
    },
    handler: async ({ user, body }) => ({
      status: 200,
      body: await UserProfileUseCase.create(
        user.id,
        user.displayName ?? 'noName',
        body.birthday,
        body.gender
      ),
    }),
  },
  delete: async ({ user }) => ({ status: 204, body: await userProfileRepo.delete(user.id) }),
}));
