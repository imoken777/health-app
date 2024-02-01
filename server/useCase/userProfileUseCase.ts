import type { UserId } from '$/commonTypesWithClient/ids';
import type { UserProfileModel } from '$/commonTypesWithClient/models';
import { userProfileRepo } from '$/repository/userProfileRepo';
import { userProfileIdParser } from '$/service/idParsers';
import { randomUUID } from 'crypto';

export const UserProfileUseCase = {
  create: async (
    userId: UserId,
    height: number,
    weight: number,
    age: number,
    targetWeight: number,
    gender: string
  ): Promise<UserProfileModel> => {
    const userProfileData: UserProfileModel = {
      id: userProfileIdParser.parse(randomUUID()),
      userId,
      height,
      weight,
      age,
      targetWeight,
      gender,
    };

    await userProfileRepo.save(userProfileData);
    return userProfileData;
  },
};
