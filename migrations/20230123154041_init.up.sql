CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE "institute" (
    "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE,
    "full_name" TEXT NOT NULL UNIQUE,
    "domain" TEXT NOT NULL UNIQUE
);

CREATE TABLE "account" (
    "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    "email" TEXT NOT NULL UNIQUE,
    "institute" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT now() NOT NULL,
    "password" TEXT,
    CONSTRAINT "account_fk2" FOREIGN KEY ("institute") REFERENCES "institute"("name") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE "profile" (
    "id" UUID PRIMARY KEY,
    "username" TEXT UNIQUE,
    "full_name" TEXT,
    "image" TEXT,
    "semester" SMALLINT NOT NULL,
    "branch" TEXT NOT NULL,
    "group" TEXT DEFAULT '' NOT NULL,
    "programme" TEXT NOT NULL,
    "year" SMALLINT NOT NULL,
    "institute" TEXT NOT NULL,
    "visibility" BOOLEAN DEFAULT true NOT NULL,
    "mess" SMALLINT,
    "electives" TEXT[] DEFAULT ARRAY[]::TEXT[],
    CONSTRAINT "profile_fk9" FOREIGN KEY ("institute") REFERENCES "institute"("name") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "profile_account_fk" FOREIGN KEY ("id") REFERENCES "account"("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE "analytics" (
    "user_id" UUID PRIMARY KEY,
    "device" TEXT,
    "fcm_token" TEXT,
    CONSTRAINT "analytics_profile_fk" FOREIGN KEY ("user_id") REFERENCES "profile"("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE "clubs" (
    "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    "name" TEXT NOT NULL,
    "club_type" TEXT NOT NULL,
    "field" TEXT NOT NULL,
    "image" TEXT,
    "coordinator" UUID,
    "cocoordinator" UUID,
    "institute" TEXT NOT NULL,
    "members" SMALLINT DEFAULT 0 NOT NULL,
    CONSTRAINT "clubs_fk5" FOREIGN KEY ("coordinator") REFERENCES "profile"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "clubs_fk6" FOREIGN KEY ("cocoordinator") REFERENCES "profile"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "clubs_fk7" FOREIGN KEY ("institute") REFERENCES "institute"("name") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE "courses" (
    "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    "institute" TEXT NOT NULL,
    "course_code" TEXT NOT NULL,
    "course_title" TEXT NOT NULL,
    "theory" BOOLEAN NOT NULL,
    "lab" BOOLEAN NOT NULL,
    "course_type" TEXT NOT NULL,
    "credits" SMALLINT NOT NULL,
    "semester" SMALLINT NOT NULL,
    "branch" TEXT NOT NULL,
    "drive_link" TEXT,
    CONSTRAINT "courses_fk1" FOREIGN KEY ("institute") REFERENCES "institute"("name") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE "mess" (
    "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    "mess_no" SMALLINT NOT NULL,
    "day" SMALLINT NOT NULL,
    "breakfast" TEXT NOT NULL,
    "lunch" TEXT NOT NULL,
    "dinner" TEXT NOT NULL,
    "institute" TEXT NOT NULL,
    CONSTRAINT "mess_fk5" FOREIGN KEY ("institute") REFERENCES "institute"("name") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE "routine" (
    "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    "course_id" UUID NOT NULL,
    "course_code" TEXT NOT NULL,
    "course_title" TEXT NOT NULL,
    "prof" TEXT NOT NULL,
    "class_type" TEXT DEFAULT 'THEORY'::text NOT NULL,
    "day" SMALLINT NOT NULL,
    "from" TIME(6) NOT NULL,
    "to" TIME(6) NOT NULL,
    "group" TEXT DEFAULT '' NOT NULL,
    "branch" TEXT NOT NULL,
    "institute" TEXT NOT NULL,
    "room" TEXT NOT NULL,
    "semester" SMALLINT NOT NULL,
    "compulsory" BOOLEAN DEFAULT true NOT NULL,
    CONSTRAINT "routine_courses_fk" FOREIGN KEY ("course_id") REFERENCES "courses"("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "routine_institute_fk" FOREIGN KEY ("institute") REFERENCES "institute"("name") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE "routine_changes" (
    "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    "created_at" TIMESTAMPTZ DEFAULT now() NOT NULL,
    "created_by" UUID DEFAULT gen_random_uuid() NOT NULL,
    "date" DATE NOT NULL,
    "description" TEXT,
    "routine_id" UUID NOT NULL,
    CONSTRAINT "routine_changes_account_fk" FOREIGN KEY ("created_by") REFERENCES "account"("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "routine_changes_routine_fk" FOREIGN KEY ("routine_id") REFERENCES "routine"("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE "admins" (
    "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    "user_id" UUID DEFAULT gen_random_uuid() NOT NULL,
    "route" TEXT,
    CONSTRAINT "admins_account_fk" FOREIGN KEY ("user_id") REFERENCES "account"("id") ON DELETE CASCADE ON UPDATE NO ACTION
);
