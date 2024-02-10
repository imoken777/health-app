import type { UserId } from '$/commonTypesWithClient/ids';
import type { UserProfileModel } from '$/commonTypesWithClient/models';
import { userProfileRepo } from '$/repository/userProfileRepo';
import type { Gender } from '@prisma/client';

export const UserProfileUseCase = {
  create: async (
    userId: UserId,
    userName: string,
    birthday: Date,
    gender: Gender
  ): Promise<UserProfileModel> => {
    const userProfileData: UserProfileModel = {
      id: userId,
      userName,
      birthday,
      gender,
    };

    await userProfileRepo.create(userProfileData);
    return userProfileData;
  },
};
