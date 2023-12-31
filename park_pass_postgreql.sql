CREATE TABLE "parking_lot" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "user_id" int NOT NULL,
  "number_of_blocks" int NOT NULL,
  "is_slot_available" tinyint(1) NOT NULL,
  "address" varchar(500) NOT NULL,
  "zip" varchar(10) NOT NULL,
  "is_reentry_allowed" tinyint(1) NOT NULL,
  "operating_company_name" varchar(100) NOT NULL,
  "is_valet_parking_available" tinyint(1) NOT NULL,
  "operational_in_night" tinyint(1) NOT NULL,
  "minimum_hr_pay" int NOT NULL,
  "is_monthly_pass_allowed" tinyint(1) NOT NULL,
  "monthly_pass_cost" int NOT NULL,
  "status" tinyint(1) NOT NULL
);

CREATE TABLE "block" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "parking_lot_id" int NOT NULL,
  "block_code" varchar(3) NOT NULL,
  "number_of_floors" int NOT NULL,
  "is_block_full" tinyint(1) NOT NULL
);

CREATE TABLE "floor" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "block_id" int NOT NULL,
  "floor_number" int NOT NULL,
  "max_height_in_inch" int NOT NULL,
  "number_of_wings" int NOT NULL,
  "number_of_slots" int NOT NULL,
  "is_covered" tinyint(1) NOT NULL,
  "is_accessible" tinyint(1) NOT NULL,
  "is_floor_full" tinyint(1) NOT NULL,
  "is_reserved_reg_cust" tinyint(1) NOT NULL
);

CREATE TABLE "parking_slot" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "floor_id" int NOT NULL,
  "slot_number" int NOT NULL,
  "wing_code" tinyint(1) NOT NULL
);

CREATE TABLE "offers" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "parking_lot_id" int NOT NULL,
  "issued_on" date NOT NULL,
  "valid_till" date NOT NULL,
  "booking_date_from" date NOT NULL,
  "booking_date_till" date NOT NULL,
  "discount_in_percentage" int,
  "max_amount_offer" int,
  "discount_in_amount" int,
  "offer_code" varchar(10)
);

CREATE TABLE "pricing_exception" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "parking_lot_id" int NOT NULL,
  "date" date NOT NULL,
  "morning_hr_cost" int NOT NULL,
  "midday_hr_cost" int NOT NULL,
  "evening_hr_cost" int NOT NULL,
  "all_day_cost" int NOT NULL
);

CREATE TABLE "parking_pricing" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "parking_lot_id" int,
  "day_of_week" int NOT NULL,
  "morning_hr_cost" int NOT NULL,
  "midday_hr_cost" int NOT NULL,
  "evening_hr_cost" int NOT NULL,
  "all_day_cost" int NOT NULL
);

CREATE TABLE "user" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "first_name" varchar(50) NOT NULL,
  "last_name" varchar(50) NOT NULL,
  "email" varchar(30) NOT NULL,
  "address" varchar(100) NOT NULL,
  "contact_number" int NOT NULL,
  "status" tinyint(1) NOT NULL,
  "avatar" blob NOT NULL,
  "username" varchar(30) NOT NULL,
  "password" varchar(30) NOT NULL
);

CREATE TABLE "role" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "name" varchar(50) NOT NULL
);

CREATE TABLE "user_role" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "user_id" int,
  "role_id" int
);

CREATE TABLE "vehicle_owner" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "user_id" int NOT NULL,
  "first_name" varchar(50) NOT NULL,
  "last_name" varchar(50) NOT NULL,
  "email" varchar(30),
  "avatar" blob NOT NULL,
  "status" tinyint(1) NOT NULL,
  "username" varchar(30) NOT NULL,
  "password" varchar(30) NOT NULL,
  "billing_address" varchar(200) NOT NULL,
  "registration_date" date NOT NULL,
  "is_regular_customer" tinyint(1) NOT NULL,
  "contact_number" int
);

CREATE TABLE "payment_method" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "vehicle_owner_id" int NOT NULL,
  "card_type" tinyint(1) NOT NULL,
  "card_number" int NOT NULL,
  "expiry_month" int NOT NULL,
  "expiry_year" int NOT NULL,
  "security_code" int NOT NULL
);

CREATE TABLE "transaction" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "payment_method_id" int NOT NULL,
  "created_time" date NOT NULL,
  "description" varchar(500) NOT NULL,
  "txn_id" varchar(100) NOT NULL,
  "dest_tag" varchar(50),
  "status" varchar(20) NOT NULL,
  "confirms" int NOT NULL,
  "amount" bigint NOT NULL,
  "network_fee" bigint NOT NULL
);

CREATE TABLE "refund" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "payment_method_id" int NOT NULL,
  "amount" bigint NOT NULL,
  "created_time" date NOT NULL
);

CREATE TABLE "vehicle" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "vehicle_category_id" int NOT NULL,
  "vehicle_owner_id" int NOT NULL,
  "plate_number" varchar(20) NOT NULL,
  "description" varchar(100) NOT NULL,
  "image" blob NOT NULL
);

CREATE TABLE "vehicle_category" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "user_id" int NOT NULL,
  "name" varchar(30) NOT NULL
);

CREATE TABLE "parking_slip" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "parking_one_time_reservation_id" int NOT NULL,
  "actual_entry_time" timestamp NOT NULL,
  "actual_exit_time" timestamp,
  "basic_cost" int NOT NULL,
  "penalty" int,
  "total_cost" int NOT NULL,
  "is_paid" tinyint(1) NOT NULL
);

CREATE TABLE "parking_one_time_reservation" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "vehicle_id" int NOT NULL,
  "parking_slot_id" int NOT NULL,
  "start_timestamp" date NOT NULL,
  "pay_for_min_hr" tinyint(1) NOT NULL,
  "booking_for_hr" int,
  "basic_parking_cost" int NOT NULL,
  "offer_code" varchar(2),
  "net_cost" int NOT NULL,
  "is_paid" tinyint(1) NOT NULL
);

CREATE TABLE "parking_monthly_pass" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY UNIQUE PRIMARY KEY NOT NULL,
  "vehicle_id" int NOT NULL,
  "parking_slot_id" int NOT NULL,
  "purchase_date" int NOT NULL,
  "start_date" date NOT NULL,
  "duration_in_day" int NOT NULL,
  "cost" int NOT NULL
);

COMMENT ON TABLE "parking_lot" IS 'Stores basic information about a parking lot.';

COMMENT ON COLUMN "parking_lot"."id" IS 'the primary key for this table.';

COMMENT ON COLUMN "parking_lot"."user_id" IS 'Parking Owner can create parking lot, one Parking owner may have multiple parking lot';

COMMENT ON COLUMN "parking_lot"."number_of_blocks" IS ' tracks the number of blocks in a parking lot.';

COMMENT ON COLUMN "parking_lot"."is_slot_available" IS ' signifies whether the parking lot currently has any available slots.';

COMMENT ON COLUMN "parking_lot"."address" IS 'stores the complete address of a parking lot.';

COMMENT ON COLUMN "parking_lot"."zip" IS 'stores the zip code of a parking lot, allowing customers to more easily search for available parking lots within a certain area by simply querying their desired zip code.';

COMMENT ON COLUMN "parking_lot"."is_reentry_allowed" IS 'signifies whether a customer may exit the parking lot and re-enter with the same parking slip. Note that many parking lots typically don’t allow customers to do this. In such parking lots, you must purchase a new slip every time you re-enter on a given day.';

COMMENT ON COLUMN "parking_lot"."operating_company_name" IS 'stores the name of the company that operates the parking lot.';

COMMENT ON COLUMN "parking_lot"."is_valet_parking_available" IS 'signifies whether the parking lot offers valet parking services.';

COMMENT ON COLUMN "parking_lot"."minimum_hr_pay" IS 'The minimum fee to park your car in a lot. For example, some lots have a three-hour minimum, meaning that you pay for three hours even if you are only parked for 30 minutes.';

COMMENT ON COLUMN "parking_lot"."is_monthly_pass_allowed" IS 'Whether a lot offers monthly passes.';

COMMENT ON COLUMN "parking_lot"."status" IS 'Status of parking lot, like ACTIVE, BLOCK, PENDING,....';

COMMENT ON TABLE "block" IS 'A parking lot is divided into one or more blocks.';

COMMENT ON COLUMN "block"."id" IS 'the primary key for this table.';

COMMENT ON COLUMN "block"."parking_lot_id" IS 'the referenced column from the parking_lot table that identifies the parking lot to which the block belongs.';

COMMENT ON COLUMN "block"."block_code" IS 'stores the code associated with this block. Blocks are usually given uniquely identifying codes, such as “A”, “B”, “C”, “11”, “22”, “33”, and so on.';

COMMENT ON COLUMN "block"."number_of_floors" IS 'stores the number of floors in this block. The number “1” indicates that this is a ground-level block with no floors.';

COMMENT ON COLUMN "block"."is_block_full" IS 'signifies whether the block is currently full.';

COMMENT ON TABLE "floor" IS 'In multi-level parking lots, blocks can have more than one floor. However, this table can also be referenced by ground-level blocks.';

COMMENT ON COLUMN "floor"."id" IS 'the primary key for this table.';

COMMENT ON COLUMN "floor"."block_id" IS 'identifies the block to which a floor belongs.';

COMMENT ON COLUMN "floor"."floor_number" IS 'represents the number of a floor (where 1 = ground level).';

COMMENT ON COLUMN "floor"."max_height_in_inch" IS 'in a multi-level parking lot, each floor has a height constraint. This column stores the maximum permissible height for vehicles on a floor.';

COMMENT ON COLUMN "floor"."number_of_wings" IS 'a floor is further divided into wings, which help customers remember where they parked. This column stores the number of wings that exist on a floor.';

COMMENT ON COLUMN "floor"."number_of_slots" IS 'stores the number of slots that exist on a floor.';

COMMENT ON COLUMN "floor"."is_covered" IS 'identifies whether a floor is covered. The top floor of a multi-level parking lot or a ground-level parking lot will never be covered.';

COMMENT ON COLUMN "floor"."is_accessible" IS 'indicates whether the floor is easily accessible, especially by the handicapped. If a multi-level lot has an operational elevator, each of its floors is considered to be accessible.';

COMMENT ON COLUMN "floor"."is_floor_full" IS 'indicates whether a floor is fully occupied.';

COMMENT ON COLUMN "floor"."is_reserved_reg_cust" IS 'indicates whether a floor is strictly reserved for regular customers.';

COMMENT ON TABLE "parking_slot" IS 'This table stores all information about the parking slots of a parking lot.';

COMMENT ON COLUMN "parking_slot"."id" IS 'primary key for this table';

COMMENT ON COLUMN "parking_slot"."floor_id" IS 'identifies the floor to which a slot belongs.';

COMMENT ON COLUMN "parking_slot"."slot_number" IS 'stores the unique identifier of the slot on a particular floor.';

COMMENT ON COLUMN "parking_slot"."wing_code" IS 'identifies the wing in which a slot is located.';

COMMENT ON TABLE "offers" IS 'It holds records of discount coupons and their associated details.';

COMMENT ON TABLE "pricing_exception" IS 'Table to record any exceptions.';

COMMENT ON TABLE "parking_pricing" IS 'Table to keep a record of regular prices ';

COMMENT ON TABLE "vehicle_owner" IS 'Stores all relevant details about all kinds of customers who may visit the parking lot (regular, one time, and prepaid).';

COMMENT ON COLUMN "vehicle_owner"."id" IS 'unique identifier for the customer.';

COMMENT ON COLUMN "vehicle_owner"."registration_date" IS 'stores the date when the vehicle was first registered with the parking lot.';

COMMENT ON COLUMN "vehicle_owner"."is_regular_customer" IS 'indicates whether a customer has regular pass. If the column stores a value of true, then there must exist a valid entry in the regular_pass table. Once a pass expires and the customer has not yet renewed it, the value in this column is updated to false.';

COMMENT ON COLUMN "vehicle_owner"."contact_number" IS 'stores a customer’s contact number. Since some people are reluctant to share their contact numbers with parking lots, we’ve kept this column nullable.';

COMMENT ON TABLE "payment_method" IS 'Since this application allows customers to reserve a parking slot and pay for it, we need a way to store payment methods. Once again, there should be a way to have multiple payment methods per user.';

COMMENT ON TABLE "vehicle" IS 'One person can have multiple cars, so we should have the capability for a one-to-many relationship between an app user and their vehicles. Obviously, we’d need a way to ID vehicles, such as by their license number.';

COMMENT ON TABLE "vehicle_category" IS 'Stores the different categories of the vehicle.';

COMMENT ON COLUMN "vehicle_category"."name" IS 'name of the category (scooters, cars, motorcycle, etc).';

COMMENT ON TABLE "parking_slip" IS 'Stores information about the customer’s entry and exit times, as well as any relevant fees';

COMMENT ON COLUMN "parking_slip"."id" IS 'the primary key for this table.';

COMMENT ON COLUMN "parking_slip"."actual_entry_time" IS 'stores the customers arrival date and timestamp.';

COMMENT ON COLUMN "parking_slip"."actual_exit_time" IS 'stores the customers departure (exit) date and timestamp.';

COMMENT ON COLUMN "parking_slip"."basic_cost" IS 'stores the basic cost of the reservation.';

COMMENT ON COLUMN "parking_slip"."penalty" IS 'stores a value of 0 by default. If a customer delays their exit, a penalty fee will be applied, and the value in this column will be updated.';

COMMENT ON COLUMN "parking_slip"."total_cost" IS 'this column merely adds the values of the basic_cost and penalty columns.';

COMMENT ON COLUMN "parking_slip"."is_paid" IS 're-entry is usually permitted only when a customer has paid their parking fee. This column denotes whether this payment has been made.';

COMMENT ON TABLE "parking_one_time_reservation" IS 'Table stores reservation details. Some of its columns are self-explanatory;';

COMMENT ON COLUMN "parking_one_time_reservation"."start_timestamp" IS 'The date and time when the reservation period starts.';

COMMENT ON COLUMN "parking_one_time_reservation"."pay_for_min_hr" IS 'Holds an N if the reservation is for a specific number of hours (e.g. from 9 a.m. until noon). Otherwise, this attribute will have a Y.';

COMMENT ON COLUMN "parking_one_time_reservation"."booking_for_hr" IS 'The number of hours of a reservation. This is a nullable field; it will have a value only when pay_for_min_hr is set to N. In the example above, it would be set to “3” for the three hours that elapse between 9 a.m. and noon.';

COMMENT ON COLUMN "parking_one_time_reservation"."basic_parking_cost" IS 'The basic parking cost, in local currency.';

COMMENT ON COLUMN "parking_one_time_reservation"."offer_code" IS 'A coupon code, if any apply. Since applying an offer code is optional and is subject to availability, this column is nullable.';

COMMENT ON COLUMN "parking_one_time_reservation"."net_cost" IS ' The actual amount customers pay at checkout (when they leave the lot).';

COMMENT ON COLUMN "parking_one_time_reservation"."is_paid" IS 'Whether parking charges have been paid. This becomes an important column when re-entry is allowed on the same parking slip. In such cases, payments are usually settled at the first checkout (i.e. the first time the car leaves the lot).';

COMMENT ON TABLE "parking_monthly_pass" IS 'Table records information about all monthly passes issued to customers through this application.';

ALTER TABLE "block" ADD FOREIGN KEY ("parking_lot_id") REFERENCES "parking_lot" ("id");

ALTER TABLE "offers" ADD FOREIGN KEY ("parking_lot_id") REFERENCES "parking_lot" ("id");

ALTER TABLE "pricing_exception" ADD FOREIGN KEY ("parking_lot_id") REFERENCES "parking_lot" ("id");

ALTER TABLE "parking_pricing" ADD FOREIGN KEY ("parking_lot_id") REFERENCES "parking_lot" ("id");

ALTER TABLE "floor" ADD FOREIGN KEY ("block_id") REFERENCES "block" ("id");

ALTER TABLE "parking_slot" ADD FOREIGN KEY ("floor_id") REFERENCES "floor" ("id");

ALTER TABLE "parking_monthly_pass" ADD FOREIGN KEY ("parking_slot_id") REFERENCES "parking_slot" ("id");

ALTER TABLE "parking_one_time_reservation" ADD FOREIGN KEY ("parking_slot_id") REFERENCES "parking_slot" ("id");

ALTER TABLE "parking_lot" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "payment_method" ADD FOREIGN KEY ("vehicle_owner_id") REFERENCES "vehicle_owner" ("id");

ALTER TABLE "vehicle" ADD FOREIGN KEY ("vehicle_owner_id") REFERENCES "vehicle_owner" ("id");

ALTER TABLE "parking_monthly_pass" ADD FOREIGN KEY ("vehicle_id") REFERENCES "vehicle" ("id");

ALTER TABLE "parking_one_time_reservation" ADD FOREIGN KEY ("vehicle_id") REFERENCES "vehicle" ("id");

ALTER TABLE "vehicle" ADD FOREIGN KEY ("vehicle_category_id") REFERENCES "vehicle_category" ("id");

ALTER TABLE "vehicle_category" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "vehicle_owner" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "user_role" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "user_role" ADD FOREIGN KEY ("role_id") REFERENCES "role" ("id");

ALTER TABLE "transaction" ADD FOREIGN KEY ("payment_method_id") REFERENCES "payment_method" ("id");

ALTER TABLE "refund" ADD FOREIGN KEY ("payment_method_id") REFERENCES "payment_method" ("id");

ALTER TABLE "parking_slip" ADD FOREIGN KEY ("parking_one_time_reservation_id") REFERENCES "parking_one_time_reservation" ("id");
