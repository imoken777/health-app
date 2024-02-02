import { useAtom } from 'jotai';
import { useForm } from 'react-hook-form';
import { Loading } from 'src/components/Loading/Loading';
import { BasicHeader } from 'src/pages/@components/BasicHeader/BasicHeader';
import { apiClient } from 'src/utils/apiClient';
import { userAtom } from '../atoms/user';
import { InputField } from './@components/InputField/InputField';

export type FormDataType = {
  height: number;
  weight: number;
  age: number;
  targetWeight: number;
  gender: string;
};

const Home = () => {
  const [user] = useAtom(userAtom);
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<FormDataType>({
    defaultValues: {
      height: 160,
      weight: 60,
      age: 20,
      targetWeight: 55,
      gender: 'women',
    },
  });

  const onSubmit = async (data: FormDataType) => {
    const processedData = {
      ...data,
      height: Number(data.height),
      weight: Number(data.weight),
      age: Number(data.age),
      targetWeight: Number(data.targetWeight),
    };
    try {
      await apiClient.userProfile.$post({ body: processedData });
    } catch (error) {
      console.error('Failed to create user profile', error);
    }
  };

  const fetchUserProfile = async () => {
    const userProfile = await apiClient.userProfile.$get();
    console.log('aaa', userProfile);
  };

  if (!user) return <Loading visible={true} />;

  return (
    <>
      <BasicHeader user={user} />
      <InputField
        label="身長"
        id="height"
        register={register}
        requiredMessage="身長の入力は必須です"
        errors={errors}
      />
      <InputField
        label="体重"
        id="weight"
        register={register}
        requiredMessage="体重の入力は必須です"
        errors={errors}
      />
      <InputField
        label="年齢"
        id="age"
        register={register}
        requiredMessage="年齢の入力は必須です"
        errors={errors}
      />
      <InputField
        label="目標体重"
        id="targetWeight"
        register={register}
        requiredMessage="目標体重の入力は必須です"
        errors={errors}
      />
      <InputField
        label="性別"
        id="gender"
        register={register}
        requiredMessage="性別の入力は必須です"
        errors={errors}
      />
      <button onClick={handleSubmit(onSubmit)}>登録</button>

      <button onClick={fetchUserProfile}>ユーザープロフィールを取得</button>
    </>
  );
};

export default Home;
