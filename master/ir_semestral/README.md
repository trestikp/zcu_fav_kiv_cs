## Implemented functions:
- [x] tokenization
- [x] preprocessing - stopwords remover
- [x] preprocessing - stemming/ lemming
- [x] in-memory inverted index
- [x] tf-idf model
- [x] cosine similarity
- [x] query returns X top queries (ordered by relevance)
- [x] boolean queries (AND, OR, NOT)
  - yes, but custom implementation 
- [x] boolean queries - brackets for priority
  - yes, but there is a bug (see documentation "Vysledky" + "Implementace" for info) 
- [x] documentation
---
#### otional:
- [x] file-based index
- [x] late index - adding documents to existing index
- [x] custom query processing implementation (not using external library)

## Data
crawled.json - https://drive.google.com/file/d/1uxee0Q7TvZjhfiC0LEluvfFEO00NiY_S/view?usp=share_link
crawled.json.zip - https://drive.google.com/file/d/1t1ezOuE5xIR4S85Gj8JnWWn4TP5JESal/view?usp=share_link

crawled.json - around 10MB sample, takes about 30 sec to index
crawled.json - around 150MB, probably takes hours? never waited for it

## Evaluation results/ review
Documentation (PavelTRESTIK_doc.pdf), section: "Vysledky"

## How to run
* import "ir_semestral" into your IDE
* put downloaded data to: storage/
  * or use practice data which are located in storage/from_practice
* run the Main.java file
  * no parameters
* done. In prompt the program should await for input ">>> "
* follow Happy day scenario

### Alternative How to Run
* requires maven installed
* change to the project location (where pom.xml is - ir_semestral)
* mvn clean compile package
* there should be runnable JAR: ./target/Indexer-1.0-jar-with-dependencies.jar
* put downloaded data to: storage/
  * or use practice data which are located in storage/from_practice
* run: java -jar target/Indexer-1.0-jar-with-dependencies.jar
* follow Happy day scenario

### Commands - using the application
- help: help or h
- new index: i n storage
  - alternatively: i n storage/crawled.json 
  - alternatively (practice data): i n storage/from_practice 
- query: q \<text>
  - q [c]os \<text>
  - q [b]ool \<text>
  - example: q bit byte computer
  - example 2: q b bit byte OR computer 
    - note: logical operators must be in UpperCase (AND, OR, NOT)
- print:
  - print page X:  p p X 
  - print doc X:  p d X
  - print indexes:  p i
    - these are currently loaded indexes which can be switched
- save index:
  - i s indexNumber path SuperIndex
  - example: i l storage/indexes/SuperIndex
- load index:
  - i l path
  - example: i l storage/indexes/SuperIndex
- setting index options:
  - s s true/ false
  - s sw true/ false
  - s i 1/2/3

### Happy day scenario
Don't forget to put crawled.json data into storage, or use storage/from_practice instead.
```
i n storage
p i
q bit byte computer
p p 3
p d 30
q b bit byte OR computer
p p 2
p d 16
q b bit (byte OR computer)
p d 1
p i
i s 1 storage/indexes SuperIndex
i l storage/indexes/SuperIndex
p i
i u 2
q bit byte computer
```