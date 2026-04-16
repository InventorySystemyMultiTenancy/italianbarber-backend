-- Disable online payment methods and keep only in-person/manual payments.

DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_name = 'appointments'
      AND column_name = 'payment_method'
  ) THEN
    UPDATE appointments
    SET payment_method = 'manual'
    WHERE payment_method IS DISTINCT FROM 'manual';

    IF EXISTS (
      SELECT 1
      FROM pg_constraint
      WHERE conname = 'appointments_payment_method_check'
    ) THEN
      ALTER TABLE appointments
        DROP CONSTRAINT appointments_payment_method_check;
    END IF;

    ALTER TABLE appointments
      ADD CONSTRAINT appointments_payment_method_check
      CHECK (payment_method IN ('manual'));
  END IF;
END $$;
