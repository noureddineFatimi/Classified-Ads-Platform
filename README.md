# 🛒 Classified Ads Platform (Inspired by Avito.ma)

This is a web application built with **Ruby on Rails**, allowing users to post, browse, and filter classified ads by category. It’s inspired by the Avito.ma website, featuring a clean and user-friendly interface.

## ✨ Features

- Homepage with top categories and latest ads  
- Hierarchical categories (parent/child)  
- Display ads by category and subcategory  
- Dynamic filters by city, category, etc.  
- Category-based dynamic ad form  
- Authentication via Devise (sign up / login)  
- Create, update, and delete ads  
- Image uploads using Active Storage  
- Sorting ads by publication date  

## 🧱 Tech Stack

- **Backend**: Ruby on Rails 7  
- **Database**: SQLite (for development) — can switch to PostgreSQL  
- **Frontend**: HTML, CSS, Stimulus, Turbo  
- **Authentication**: Devise  
- **Image Handling**: Active Storage  
- **Icons/Categories**: Static SVGs  

## 📁 Project Structure
- **app/models**: application models (Ad, Category, User, etc.)

- **app/controllers**: business logic (CRUD, filters...)

- **app/views**: HTML templates with embedded Ruby

- **app/javascript**: Stimulus and Turbo JavaScript components

- **storage/**: uploaded files via Active Storage

## 📖 Report

Report of project on [drive](https://drive.google.com/file/d/1WluCIECINikt97hXHmuGxOlGPlJf8Wz7/view?usp=drive_link)

## 🔒 Authentication

Only logged-in users can create, edit, or delete ads

## 📄 License

Academic project – For educational use.




