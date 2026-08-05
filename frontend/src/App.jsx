import { useEffect, useState } from "react";
import "./App.css";

function App() {
  const [backendStatus, setBackendStatus] = useState("Checking...");
  const [backendMessage, setBackendMessage] = useState(
    "Trying to connect to the Spring Boot backend."
  );

  useEffect(() => {
    fetch("/api/actuator/health")
      .then((response) => {
        if (!response.ok) {
          throw new Error("Backend request failed");
        }

        return response.json();
      })
      .then((data) => {
        setBackendStatus("Connected");
        setBackendMessage("Backend health: " + data.status);
      })
      .catch(() => {
        setBackendStatus("Not connected yet");
        setBackendMessage(
          "The frontend is running. The backend will be connected through the AWS ALB Ingress."
        );
      });
  }, []);

  return (
    <main className="container">
      <section className="card">
        <span className="badge">FULL-STACK DEVOPS PROJECT</span>

        <h1>BuzzBoard</h1>

        <p className="description">
          React, Spring Boot, PostgreSQL, Docker, Amazon EKS, and AWS ALB.
        </p>

        <section className="health-card">
          <h2>Backend Status: {backendStatus}</h2>
          <p>{backendMessage}</p>
        </section>

        <section className="services">
          <article>
            <h3>Frontend</h3>
            <p>React + Vite + Nginx</p>
          </article>

          <article>
            <h3>Backend</h3>
            <p>Spring Boot on Amazon EKS</p>
          </article>

          <article>
            <h3>Database</h3>
            <p>Amazon RDS PostgreSQL</p>
          </article>
        </section>
      </section>
    </main>
  );
}

export default App;
