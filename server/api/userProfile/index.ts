import type { UserProfileModel } from '$../../commonTypesWithClient/models';
import type { Gender } from '@prisma/client';
import type { DefineMethods } from 'aspida';

export type Methods = DefineMethods<{
  get: {
    resBody: UserProfileModel | null;
  };
  post: {
    reqBody: {
      birthday: number;
      gender: Gender;
    };
    resBody: UserProfileModel;
  };
  delete: { resBody: UserProfileModel };
}>;
