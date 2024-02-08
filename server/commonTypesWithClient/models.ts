import type { Gender, MealType } from '@prisma/client';
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

export type UserProfile = {
  userId: string;
  userName: string;
  height: number;
  gender: Gender;
  targetWeight: number;
  birthday: Date;
  Month: Month[];
  WeightHistory: WeightHistory[];
  BookMark: BookMark[];
};

export type Month = {
  id: string;
  month: number;
  userId: string;
  user: UserProfile;
  Days: Day[];
  SNSId?: string;
  SNSPost?: SNSPost;
};

export type Day = {
  id: string;
  day: number;
  monthId: string;
  month: Month;
  MealMenus: MealMenu[];
  Movements: Movement[];
};

export type Ingredient = {
  id: string;
  name: string;
  amount: number;
  recipeId: string;
  Recipe: Recipe;
};

export type Recipe = {
  id: string;
  name: string;
  memo: string;
  ingredients: Ingredient[];
  MealMenus: MealMenuRecipe[];
};

export type MealMenu = {
  id: string;
  mealType: MealType;
  date: Date;
  time: Date;
  Recipes: MealMenuRecipe[];
  dayId: string;
  Day: Day;
  SNSId?: string;
  SNSPost?: SNSPost;
};

export type MealMenuRecipe = {
  id: string;
  RecipeId: string;
  MealMenuId: string;
  Recipe: Recipe;
  MealMenu: MealMenu;
};

export type Movement = {
  id: string;
  name: string;
  duration: number;
  time: Date;
  dayId: string;
  day: Day;
  SNSId?: string;
  SNSPost?: SNSPost;
};

export type WeightHistory = {
  weight: number;
  day: Date;
  userId: string;
  user: UserProfile;
  SNSId?: string;
  SNSPost?: SNSPost;
};

export type BookMark = {
  id: string;
  name: string;
  userId: string;
  user: UserProfile;
};

export type SNSPost = {
  id: string;
  userId: string;
  postedAt: Date;
  post?: WeightHistory;
  Month?: Month;
  MealMenu?: MealMenu;
  Movement?: Movement;
  Likes: Reaction[];
  monthId?: string;
  mealMenuId?: string;
  movementId?: string;
};

export type Reaction = {
  userId: string;
  reaction: string;
  SNSPostId?: string;
  SNSPost?: SNSPost;
};
