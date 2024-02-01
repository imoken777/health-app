import { userProfileRepo } from '$/repository/userProfileRepo';
import { UserProfileUseCase } from '$/useCase/userProfileUseCase';
import { defineController } from './$relay';

export default defineController(() => ({
  get: async ({ user }) => ({
    status: 200,
    body: await userProfileRepo.getByUserId(user.id),
  }),
  post: async ({ user, body }) => ({
    status: 200,
    body: await UserProfileUseCase.create(
      user.id,
      body.height,
      body.weight,
      body.age,
      body.targetWeight,
      body.gender
    ),
  }),
}));
