import type { Gender, MealType } from '@prisma/client';
import { z } from 'zod';
import { taskIdParser } from '../service/idParsers';
import type { UserId } from './ids';

export type UserModel = {
  id: UserId;
  email: string;
  displayName: string | undefined;
  photoURL: string | undefined;
};

export const taskParser = z.object({
  id: taskIdParser,
  label: z.string(),
  done: z.boolean(),
  created: z.number(),
});

export type TaskModel = z.infer<typeof taskParser>;

export type UserProfileModel = {
  id: string;
  userName: string;
  gender: Gender;
  birthday: Date;
};

export type MonthModel = {
  id: string;
  month: number;
  userId: string;
  SNSId?: string;
};

export type DayModel = {
  id: string;
  day: number;
  monthId: string;
};

export type IngredientModel = {
  id: string;
  name: string;
  amount: number;
  recipeId: string;
};

export type RecipeModel = {
  id: string;
  name: string;
  memo: string;
};

export type MealMenuModel = {
  id: string;
  mealType: MealType;
  date: Date;
  time: Date;
  dayId: string;
  SNSId?: string;
};

export type MealMenuRecipeModel = {
  id: string;
  RecipeId: string;
  MealMenuId: string;
};

export type MovementModel = {
  id: string;
  name: string;
  duration: number;
  time: Date;
  dayId: string;
  SNSId?: string;
};

export type PhysiqueHistoryModel = {
  weight: number;
  height: number;
  targetWeight: number;
  day: Date;
  userId: string;
  SNSId?: string;
};

export type BookMarkModel = {
  id: string;
  name: string;
  userId: string;
};

export type SNSPostModel = {
  id: string;
  userId: string;
  postedAt: Date;
  monthId?: string;
  mealMenuId?: string;
  movementId?: string;
};

export type ReactionModel = {
  userId: string;
  reaction: string;
  SNSPostId?: string;
};
