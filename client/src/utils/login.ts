import { GoogleAuthProvider, signInWithPopup } from 'firebase/auth';
import { createAuth } from 'src/utils/firebase';
import { returnNull } from './returnNull';

export const loginWithGoogle = async () => {
  const provider = new GoogleAuthProvider();
  provider.addScope('https://www.googleapis.com/auth/contacts.readonly');

  await signInWithPopup(createAuth(), provider).catch(returnNull);
};

export const logout = async () => {
  await createAuth().signOut();
};
