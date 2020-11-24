import os
import string
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize



# -----------------------------------------------------------------------------------------
# Original Function

# filenames = ['Group Project 1 Text for Analysis.txt', 'Obama_Speech_2-24-09.txt', 'Obama_Speech_1-27-10.txt']

# for filename in filenames:
#     # load data
#     file = open(filename, 'rt')
#     text = file.read()
#     file.close()

#     # split the text by whitespace
#     words = text.split()
#     # remove the punctuations in the words

#     table = str.maketrans('', '', string.punctuation)

#     puncRemoved = [w.translate(table) for w in words]

#     # remove the word that is not alphabetic and lower the word one by one
#     output = [w.lower() for w in puncRemoved if w.isalpha()]
#     print(output)

# -----------------------------------------------------------------------------------------

# NLTk Function

filenames = ['Group Project 1 Text for Analysis.txt', 'Obama_Speech_2-24-09.txt', 'Obama_Speech_1-27-10.txt']

for filename in filenames:
    # load data~~
    file = open(filename, 'rt')
    text = file.read()
    file.close()

    # use a function word_tokenize from nltk to split the text into words
    tokens = word_tokenize(text)

    # remove punctuation from each word
    table = str.maketrans('', '', string.punctuation)
    puncRemoved  = [w.translate(table) for w in tokens]

    # remove the word that is not alphabetic and lower the word one by one
    words = [w.lower() for w in puncRemoved if w.isalpha()]

    # remove stop words
    stop_words = set(stopwords.words('english'))
    output = [w for w in words if not w in stop_words]
    print(words)

    output_filename = "Output_" + filename
    f = open(output_filename,'w')
    for word in output:
        f.write(word + " : " + "1\n")
    f.close