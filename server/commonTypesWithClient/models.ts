import { z } from 'zod';
import { taskIdParser } from '../service/idParsers';
import type { UserId, UserProfileId } from './ids';

export type UserModel = {
  id: UserId;
  email: string;
  displayName: string | undefined;
  photoURL: string | undefined;
};

export type UserProfileModel = {
  id: UserProfileId;
  userId: UserId;
  height: number;
  weight: number;
  age: number;
  targetWeight: number;
  gender: string;
};

export const taskParser = z.object({
  id: taskIdParser,
  label: z.string(),
  done: z.boolean(),
  created: z.number(),
});

export type TaskModel = z.infer<typeof taskParser>;
