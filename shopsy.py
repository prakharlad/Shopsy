#!/usr/bin/python3

import cgi

print("content-type:text/html")
print()

data=cgi.FieldStorage()
q = data.getvalue("q")
q= q.lower()

if("good morning" in q):
	print("Hey,Good Morning")

elif("good evening" in q):
	print("Hey,Good Evening. Hope you are doing well")

elif("good afternoon" in q):
	print("Hey, Good Afternoon. How can I help you?")

elif("who are you" in q):
	print("I am Shopsy bot . I am there to help you with selecting the book of your choice")

elif("fine" in q):
	print("Great")

elif("hi" == q or "hello" == q or "heya" == q or "hey" == q):
	print("hey , how are you? ")

elif("buy book" in q or "purchase book" in q or "i want to buy book" in q or "want to buy book" in q or "want to purchase a book" in q or "want to purchase a book" in q or "wish to buy book of my choice" in q or "help me in selecting book" in q):
	print("We have different categories of books available. Like romantic, murder,mythological and historical etc which category you want to buy?")

elif("want to buy novel" in q or "purchase novel" in q or "buy novel" in q or "suggest novel" in q or "help me with selecting novel" in q):
	print("We have different categories of novels available. Like romantic, murder, thrilling etc which category you want to buy?")

elif ("mythological" in q):
	print("Yes, we have mythological books in our collection .Here,the best 5 popular books in mythology are \n 1.The Shiva Trilogy \n 2.Palace of Illusions \n 3.My Gita \n 4.Rise of Kali \n 5.Kalki ")

elif ("bestsellers" in q):
	print("Yes, we have bestsellers books in our collection .Here,the 5 Bestsellers books \n \n 1.The Hobbit \n 2.Harry Potter and the Philosopher's Stone \n 3.The Little Prince \n 4.Dream of the Red Chamber \n 5.And Then There Were None ")


elif ("fictional" in q):
	print("Yes, we have fictional books in our collection .Here, some  best fictional books \n\n 1.19 TILL I DIE \n 2.1984 \n 3.50 Greatest Short Stories \n 4.A Hundred Lives for You \n 5.A Night in the Hills ")

elif ("romantic" in q or "romance" in q):
	print("Yes, we have various romantic novels in our collection .Here,the best 5 popular books in romantic are \n\n 1.It Ends With Us \n 2.The Proposal \n 3.The Hating Game \n 4.Vision In White \n 5.Beautiful Disaster ")

elif ("mystery" in q or "crime" in q or "triller" == q or "murder" in q or "thrilling" in q):
	print("Yes, we have various crime, thriller and mystery novels in our collection .Here,the best 5 books in crime , murder and mystery are \n\n 1.400 Days \n 2.The Silent Patient \n 3.Over my Deed Body \n 4.Hotel \n 5.The Judge's Guest")

elif ("popular author" in q):
	print("Yes, we have various popular authors novels in our collection .Here,the best 5 popular authors book are \n\n 1.400 Days by Chetan Bhagat \n 2.A Brutal Hand: There's No Escape by Ravi Subramanian \n 3.A GALLERY OF RASCALS by Ruskin Bond \n 4.A Hundred Little Flames by Preeti Shenoy \n 5.A Song of Ice and Fire - A Game of Thrones Boxset: The Story Continues by George R R Martin")


elif ("biography" in q or "autobiography" in q):
	print("Yes, we have various biography novels in our collection. Here,the best 5 popular autobiographies are \n\n 1.71 Famous Scientists \n 2.75 People Who Changed The World \n 3.A Biography of SWAMI VIVEKANANDA \n 4.Abraham Lincoln (The Inspirational Wisdom of Abraham Lincoln) \n 5.Albert Einstein: A Short Biography ")

elif ("historical" in q or "history" in q):
	print("Yes, we have various historical novels in our collection .Here,the best 5 historic books are \n\n 1.A Feast Of Roses \n 2.A Plate of White Marble \n 3.Adam Runaway \n 4.Ashoka: Lion of Maurya \n 5.Chanakya Neeti ")


elif ("political" in q or "politics" in q):
	print("Yes, we have various political novels in our collection .Here,the best 5 popular books in politics are \n\n 1.A Promised Land \n 2.बीजेपी : कल, आज और कल  \n 3.Governance for Growth in India \n 4.Know About RSS \n 5.Long Walk To Freedom ")

else: 
	print("Did not get it will you please explain. How may I help you ?")

