package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/nihad/todo/routes"
	"github.com/thedevsaddam/renderer"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var rnd *renderer.Render
var db *mongo.Database

const (
	dbName string = "demo_todo"
	port   string = ":9000"
)

func init() {
	rnd = renderer.New()

	// Get MongoDB URL from environment variable or use localhost as fallback
	mongoURL := os.Getenv("MONGO_URL")
	if mongoURL == "" {
		mongoURL = "mongodb://localhost:27017"
		log.Println("🔗 Using default MongoDB connection: localhost:27017")
	} else {
		log.Printf("🔗 Connecting to MongoDB: %s\n", mongoURL)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	client, err := mongo.Connect(ctx, options.Client().ApplyURI(mongoURL))
	checkErr(err)

	db = client.Database(dbName)
	log.Printf("✅ Successfully connected to database: %s\n", dbName)
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	err := rnd.Template(w, http.StatusOK, []string{"static/home.tpl"}, nil)
	checkErr(err)
}

func main() {
	stopChan := make(chan os.Signal, 1)
	signal.Notify(stopChan, os.Interrupt)

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Get("/", homeHandler)

	r.Mount("/todo", routes.TodoRoutes(db, rnd))

	srv := &http.Server{
		Addr:         port,
		Handler:      r,
		ReadTimeout:  60 * time.Second,
		WriteTimeout: 60 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	go func() {
		log.Println("🚀 ===============================================")
		log.Println("🚀 Modern Todo Manager Server")
		log.Printf("🚀 Server is running on http://localhost%s\n", port)
		log.Println("🚀 Press Ctrl+C to stop the server")
		log.Println("🚀 ===============================================")
		if err := srv.ListenAndServe(); err != nil {
			log.Printf("❌ Listen error: %s\n", err)
		}
	}()

	<-stopChan
	log.Println("\n🛑 Shutting down server gracefully...")
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	srv.Shutdown(ctx)
	defer cancel()
	log.Println("✅ Server stopped successfully! Goodbye! 👋")
}

func checkErr(err error) {
	if err != nil {
		log.Fatal(err) //respond with error page or message
	}
}
