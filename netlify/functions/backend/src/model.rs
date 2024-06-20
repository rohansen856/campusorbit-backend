use serde::{Serialize, Deserialize};
use sqlx::prelude;
use uuid::Uuid;
use chrono::{DateTime, Utc};

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct AccountModel {
    pub id: Uuid,
    pub email: String,
    pub institute: String,
    pub created_at: DateTime<Utc>,
    pub password: Option<String>,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct AnalyticsModel {
    pub user_id: Uuid,
    pub device: Option<String>,
    pub fcm_token: Option<String>,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct ClubsModel {
    pub id: Uuid,
    pub name: String,
    pub club_type: String,
    pub field: String,
    pub image: Option<String>,
    pub coordinator: Option<Uuid>,
    pub cocoordinator: Option<Uuid>,
    pub institute: String,
    pub members: i16,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct CoursesModel {
    pub id: Uuid,
    pub institute: String,
    pub course_code: String,
    pub course_title: String,
    pub theory: bool,
    pub lab: bool,
    pub course_type: String, // `type` is a reserved keyword in Rust
    pub credits: i16,
    pub semester: i16,
    pub branch: String,
    pub drive_link: Option<String>,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct InstituteModel {
    pub id: Uuid,
    pub name: String,
    pub full_name: String,
    pub domain: String,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct MessModel {
    pub id: Uuid,
    pub mess_no: i16,
    pub day: i16,
    pub breakfast: String,
    pub lunch: String,
    pub dinner: String,
    pub institute: String,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct ProfileModel {
    pub id: Uuid,
    pub username: Option<String>,
    pub full_name: Option<String>,
    pub image: Option<String>,
    pub semester: i16,
    pub branch: String,
    pub group: String,
    pub programme: String,
    pub year: i16,
    pub institute: String,
    pub visibility: bool,
    pub mess: Option<i16>,
    pub electives: Vec<String>,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct RoutineModel {
    pub id: Uuid,
    pub course_id: Uuid,
    pub course_code: String,
    pub course_title: String,
    pub prof: String,
    pub class_type: String, // `type` is a reserved keyword in Rust
    pub day: i16,
    pub from: chrono::NaiveTime,
    pub to: chrono::NaiveTime,
    pub group: String,
    pub branch: String,
    pub institute: String,
    pub room: String,
    pub semester: i16,
    pub compulsory: bool,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct RoutineChangesModel {
    pub id: Uuid,
    pub created_at: DateTime<Utc>,
    pub created_by: Uuid,
    pub date: chrono::NaiveDate,
    pub description: Option<String>,
    pub routine_id: Uuid,
}

#[derive(Debug, Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct AdminsModel {
    pub id: Uuid,
    pub user_id: Uuid,
    pub route: Option<String>,
}
