import type { UserProfileModel } from 'commonTypesWithClient/models';
import { useAtom } from 'jotai';
import { useState } from 'react';
import { Loading } from 'src/components/Loading/Loading';
import { BasicHeader } from 'src/pages/@components/BasicHeader/BasicHeader';
import { apiClient } from 'src/utils/apiClient';
import { userAtom } from '../atoms/user';
type Gender = 'Male' | 'Female' | 'Other';

const Home = () => {
  const [user] = useAtom(userAtom);
  const [userProfile, setUserProfile] = useState<UserProfileModel>();
  const createUserProfile = async () => {
    const body: { gender: Gender; birthday: number } = {
      gender: 'Male',
      birthday: Date.now(),
    };
    await apiClient.userProfile.$post({ body });
  };

  const fetchUserProfile = async () => {
    const res = await apiClient.userProfile.$get();
    if (res === null) return;
    setUserProfile(res);
  };
  if (user === null) return <Loading visible={true} />;
  return (
    <>
      <BasicHeader user={user} />
      <button onClick={createUserProfile}>Create User Profile</button>
      <button onClick={fetchUserProfile}>Fetch User Profile</button>
    </>
  );
};

export default Home;
