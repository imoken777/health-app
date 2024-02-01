import { z } from 'zod';
import type { TaskId, UserId, UserProfileId } from '../commonTypesWithClient/ids';

const createIdParser = <T extends string>() => z.string() as unknown as z.ZodType<T>;

export const userIdParser = createIdParser<UserId>();

export const userProfileIdParser = createIdParser<UserProfileId>();

export const taskIdParser = createIdParser<TaskId>();
