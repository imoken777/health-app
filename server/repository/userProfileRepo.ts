import type { UserId } from '$/commonTypesWithClient/ids';
import type { UserProfileModel } from '$/commonTypesWithClient/models';
import { userIdParser } from '$/service/idParsers';
import { prismaClient } from '$/service/prismaClient';
import type { UserProfile as PrismaUserProfile } from '@prisma/client';
import { Gender } from '@prisma/client';
import { z } from 'zod';

// UserProfiles
const toUserProfileModel = (prismaUserProfile: PrismaUserProfile): UserProfileModel => ({
  id: userIdParser.parse(prismaUserProfile.id),
  userName: z.string().parse(prismaUserProfile.userName),
  gender: z.nativeEnum(Gender).parse(prismaUserProfile.gender),
  birthday: prismaUserProfile.birthday.getTime(),
});

export const userProfileRepo = {
  create: async (userProfile: UserProfileModel) => {
    const prismaUserProfile = await prismaClient.userProfile.create({
      data: {
        id: userProfile.id,
        userName: userProfile.userName,
        gender: userProfile.gender,
        birthday: new Date(userProfile.birthday),
      },
    });
    return toUserProfileModel(prismaUserProfile);
  },
  getByUserId: async (userId: UserId): Promise<UserProfileModel | null> => {
    try {
      const prismaUserProfile = await prismaClient.userProfile.findUnique({
        where: { id: userId },
      });
      if (prismaUserProfile === null) {
        return null;
      }
      return toUserProfileModel(prismaUserProfile);
    } catch (e) {
      console.error(e);
      return null;
    }
  },
  delete: async (userId: UserId) => {
    const prismaUserProfile = await prismaClient.userProfile.delete({
      where: { id: userId },
    });
    return toUserProfileModel(prismaUserProfile);
  },
};
