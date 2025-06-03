
# 🎓 Course Web - Student Course Registration Management System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) Welcome to **Course Web**, a web-based Student Course Registration Management System. This project was developed as part of the SLIIT Faculty of Computing, Year 1 Semester 2 Object-Oriented Programming (OOP) module (Project P-153). It allows students to browse and register for courses, while administrators can manage course offerings, student enrollments, and system announcements.

## ✨ Key Features

* **👤 User Authentication:** Secure registration and login for students and administrators.
* **👨‍🎓 Student Portal:**
    * View personal profile.
    * Browse a comprehensive list of available courses with details.
    * Register for desired courses.
    * View currently registered courses.
    * Submit requests or contact administrators.
* **🔑 Administrator Panel:**
    * Manage student accounts (view, edit details).
    * Manage courses (add new courses, update existing ones, remove courses).
    * Oversee course enrollments.
    * Post and manage system-wide announcements.
    * Handle student requests and contacts.
* **💾 Data Persistence:** Utilizes text files for storing and retrieving application data (users, courses, enrollments, etc.).
* **🧱 OOP Principles:** Designed and implemented using core Object-Oriented Programming concepts in Java.

## 🎨 Class Diagram

Our project's architectural design is visualized in the class diagram below:

[View Full Class Diagram on Mermaid Chart](https://www.mermaidchart.com/raw/90716b4d-0cb3-4ede-a367-aef6f5693bb2?theme=light&version=v0.1&format=svg)

## 🛠️ Technologies & Tools

* **Core Language:** Java `[Specify JDK version, e.g., 8 or 11+]`
* **Web Technologies:**
    * Servlets `[Specify Servlet API version if known, e.g., 3.1 or 4.0]`
    * JSP (JavaServer Pages) `[Specify JSP version if known, e.g., 2.3]`
* **Build Automation:** Apache Maven `[Specify Maven version, e.g., 3.6+]`
* **Data Storage:** Text Files (`.txt`) for database operations.
* **Web Server / Servlet Container:** Apache Tomcat `[Specify Tomcat version, e.g., 9.x]`
* **Development Environment:** `[e.g., IntelliJ IDEA, Eclipse, NetBeans]`
* **Version Control:** Git & GitHub

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Ensure you have the following software installed:

* Java Development Kit (JDK) - `[e.g., Version 11 or higher recommended]`
* Apache Maven - `[e.g., Version 3.6.0 or higher]`
* Apache Tomcat - `[e.g., Version 9.0 or higher]` (Required if you deploy the WAR file manually, otherwise the Maven plugin can manage it)
* A Git client (for cloning the repository)

### Installation & Setup

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/IT24102936/OOP-Project_P-153.git](https://github.com/IT24102936/OOP-Project_P-153.git)
    ```

2.  **Navigate to Project Directory:**
    ```bash
    cd OOP-Project_P-153
    ```

3.  **Data Files:**
    The application uses text files for data storage, located within `src/main/resources/data/`. These files (`admin.txt`, `announcements.txt`, etc.) are included in the repository. No external database configuration is needed.
    * Ensure your operating system allows read/write access to these files for the Java application.

4.  **Build with Maven:**
    Compile the project and package it into a WAR (Web Application Archive) file.
    ```bash
    mvn clean install
    ```
    This command will also download all necessary dependencies as defined in the `pom.xml`.

### 🏃 Running the Application

You can run the application using the Maven Tomcat plugin (recommended for ease of development) or by deploying the generated `.war` file to a standalone Tomcat server.

* **Option 1: Using Maven Tomcat Plugin**
    Your `pom.xml` should ideally have the `tomcat7-maven-plugin` (or a similar version like `tomcat8-maven-plugin` or `tomcat9-maven-plugin`) configured.
    If not, you can add it:
    ```xml
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.tomcat.maven</groupId>
                <artifactId>tomcat7-maven-plugin</artifactId>
                <version>2.2</version> <configuration>
                    <path>/CourseWeb</path> <port>8080</port>      </configuration>
            </plugin>
        </plugins>
    </build>
    ```
    Then, execute:
    ```bash
    mvn tomcat7:run
    ```
    The application will be accessible at: `http://localhost:8080/CourseWeb`

* **Option 2: Deploying to a Standalone Tomcat Server**
    1.  After running `mvn clean install`, a `.war` file (e.g., `OOP-Project_P-153.war` or `CourseWeb.war` depending on your `pom.xml` artifactId) will be created in the `target/` directory.
    2.  Copy this `.war` file to the `webapps/` directory of your standalone Apache Tomcat installation.
    3.  Start your Apache Tomcat server.
    4.  The application will typically be available at `http://localhost:8080/YourWarFileName` (e.g., `http://localhost:8080/OOP-Project_P-153`).

## 📖 How to Use

Once the application is running:

1.  Open your web browser and navigate to `http://localhost:8080/CourseWeb` (or the appropriate URL based on your deployment).
2.  **Students:**
    * Register for a new account or log in if you already have one.
    * Browse the list of available courses.
    * Click on courses to view details and register.
    * Check your profile to see your registered courses.
3.  **Administrators:**
    * Log in using administrative credentials. `[Specify default admin credentials if any, e.g., Username: admin, Password: admin123 - and advise to change it]`
    * Access the admin dashboard to:
        * Manage course listings (add, edit, delete).
        * Manage student accounts.
        * View enrollments.
        * Post announcements.

## 🏛️ Project File Structure

Here's an overview of the project's directory structure:

```bash
OOP-Project_P-153/
├── .idea/ # IDE specific files (e.g., IntelliJ)
├── src/
│ ├── main/
│ │ ├── java/
│ │ │ └── com/oop/project/ # Core Java source code
│ │ │ ├── model/ # POJOs (Plain Old Java Objects) / Data Entities
│ │ │ ├── service/ # Business logic and service layer
│ │ │ ├── servlets/ # HTTP Servlet controllers
│ │ │ └── util/ # Utility classes and helpers
│ │ ├── resources/
│ │ │ └── data/ # Text files acting as the database
│ │ │ ├── admin.txt
│ │ │ ├── announcements.txt
│ │ │ ├── contacts.txt
│ │ │ ├── courses.txt
│ │ │ ├── enrollments.txt
│ │ │ ├── requests.txt
│ │ │ └── students.txt
│ │ └── webapp/ # Web application content
│ │ ├── course_img/ # Images specific to courses
│ │ ├── css/ # CSS stylesheets
│ │ ├── img/ # General images for UI
│ │ ├── js/ # JavaScript files for client-side interactivity
│ │ ├── WEB-INF/
│ │ │ └── web.xml # Deployment Descriptor (Servlet mappings, etc.)
│ │ ├── Admin-addcourse.jsp
│ │ ├── Admin-announcement.jsp
│ │ ├── Admin-contactus.jsp
│ │ ├── Admin-courselist.jsp
│ │ ├── Admin-dashboard.jsp
│ │ ├── Admin-management.jsp
│ │ ├── Admin-navbar.jsp
│ │ ├── Admin-requestlist.jsp
│ │ ├── Admin-studentlist.jsp
│ │ ├── Admin-useredit.jsp
│ │ ├── contactform.jsp
│ │ ├── Courses.jsp
│ │ ├── Dashboard.jsp
│ │ ├── footer.jsp
│ │ ├── Login.jsp
│ │ ├── navbar.jsp
│ │ ├── Profile.jsp
│ │ ├── Registration.jsp
│ │ └── Request_list.jsp
├── pom.xml # Maven Project Object Model (dependencies, build config)
└── README.md # This file!
```

## 🖼️ Screenshots

Here's a glimpse of the Course Web application in action:

### Login Page
![Login Page](https://i.ibb.co/xqBx2DSC/image.png)

### Registration Page
![Registration Page](https://i.ibb.co/Y7cBbKNw/image.png)

### Student Dashboard
![Student Dashboard](https://i.ibb.co/XxQmK9M9/image.png)

### Course List (Student View)
![Course List](https://i.ibb.co/ccBDDcsK/image.png)

### Admin Dashboard / UI
![Admin UI](https://i.ibb.co/Q3DXmGR6/image.png)




## 🧑‍💻 Authors & Acknowledgments

This project was developed by **Group P-153**:

* **[Rasanjana S.P (IT24102936)](https://github.com/IT24102936) - (Leader)**
* [Ilham M.M (IT24103530)](https://github.com/IT24103530)
* [Sathurusingha S.A.P.V. (IT24102898)](https://github.com/IT24102898)
* [Herath H.M.B.M (IT24103899)](https://github.com/IT24103899)
* [Nawarathna M.S.G. (IT24104206)](https://github.com/IT24104206)
* [Dolamulla H.D.K.P.D (IT24103522)](https://github.com/IT24103522)

We would like to acknowledge the guidance and support from the teaching staff of the Object-Oriented Programming module at SLIIT Faculty of Computing.

## 📜 License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.
*(If you haven't added a `LICENSE.md` file, consider creating one. The MIT License is a good, permissive option for open source projects.)*

---

We hope you find Course Web useful and easy to explore! If you have any questions or feedback, feel free to open an issue on the repository.
