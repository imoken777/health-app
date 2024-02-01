import type { UserProfileModel } from '$../../commonTypesWithClient/models';
import type { DefineMethods } from 'aspida';

export type Methods = DefineMethods<{
  get: {
    resBody: UserProfileModel | null;
  };
  post: {
    reqBody: {
      height: number;
      weight: number;
      age: number;
      targetWeight: number;
      gender: string;
    };
    resBody: UserProfileModel;
  };
}>;
