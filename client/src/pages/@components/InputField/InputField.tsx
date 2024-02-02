import type { FieldErrors, FieldValues, UseFormRegister } from 'react-hook-form';
import type { FormDataType } from 'src/pages/index.page';

type InputFieldProps<FormDataType extends FieldValues> = {
  label: string;
  id: keyof FormDataType;
  register: UseFormRegister<FormDataType>;
  requiredMessage: string;
  errors: FieldErrors<FormDataType>;
};

export const InputField = ({
  label,
  id,
  register,
  requiredMessage,
  errors,
}: InputFieldProps<FormDataType>) => {
  return (
    <div>
      <label htmlFor={id}>{label}</label>
      {id === 'gender' ? (
        <>
          <input
            id={`${id}-women`}
            type="radio"
            value="women"
            {...register(id, { required: requiredMessage })}
          />{' '}
          女性
          <input
            id={`${id}-men`}
            type="radio"
            value="men"
            {...register(id, { required: requiredMessage })}
          />{' '}
          男性
        </>
      ) : (
        <input id={id} type="number" {...register(id, { required: requiredMessage })} />
      )}
      {Boolean(errors[id]?.message) && <div>{errors[id]?.message}</div>}
    </div>
  );
};
