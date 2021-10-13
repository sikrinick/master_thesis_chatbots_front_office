from enum import Enum
from dataclasses import dataclass
from typing import List, Dict, Optional
import os
import csv

import matplotlib.pyplot as plt
from matplotlib.figure import Figure

class Age(Enum):
    FIRST_CATEGORY = 0
    SECOND_CATEGORY = 1
    THIRD_CATEGORY = 2

    def __str__(self) -> str:
        if self == Age.FIRST_CATEGORY:
            return "18-32"
        elif self == Age.SECOND_CATEGORY:
            return "33-48"
        elif self == Age.THIRD_CATEGORY:
            return "49+"
        else:
            return "Unknown age"

@dataclass
class Answer:
    question: str
    answer: int

@dataclass
class ClientPortrait:
    id: int
    age: Age
    answers: List[Answer]



script_path = os.path.dirname(os.path.realpath(__file__))
os.chdir(script_path)

clients: List[ClientPortrait] = []
with open('survey.csv', 'r', newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    header = next(reader)
    for row in reader:
        if (len(row) == 0):
            break
        answers = [
            Answer(
                question=header[idx+2],
                answer=int(answer)
            ) 
            for idx, answer in enumerate(row[2:])
        ]
        clients.append(
            ClientPortrait(
                id=int(row[0]),
                age=Age(int(row[1])),
                answers=answers
            )
        )

answer_dict: Dict[str, List[int]] = {}
for client in clients:
    for answer in client.answers:
        answer_dict.setdefault(answer.question, []).append(answer.answer)

@dataclass
class Legend:
    question: str
    labels: Optional[List[str]]

def update_size() -> Figure:
    figure = plt.figure()
    figure.set_figwidth(7)
    figure.set_figheight(5)
    return figure

figure = update_size()
question = "How old are you?"
plt.suptitle(question)
ages = [client.age.value for client in clients]
plt.hist(ages, bins=[x for i in [0,1,2] for x in (i-0.4,i+0.4)])
plt.xticks(
    [0, 1, 2],
    ["18-32", "33-48", "49+"]
)
plt.show()
figure.savefig("1_" + question.lower().replace(" ", "_") + ".png")

plot_dict = {}
for idx, question in enumerate(answer_dict.keys()):
    figure = update_size()
    plt.suptitle(question)
    if idx == 0:
        answers = answer_dict[question]
        plt.hist(
            answers,
            bins=[x for i in [1,2,3,4,5] for x in (i-0.4,i+0.4)]
        )
    else:
        answers = answer_dict[question]
        plt.hist(
            answers, 
            bins=[x for i in [0,1,2,3,4] for x in (i-0.4,i+0.4)]
        )
        plt.xticks(
            [0, 1, 2, 3, 4],
            ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"]
        )
    plt.show()
    file_idx = str(idx + 2)
    figure.savefig(file_idx + "_" + question.lower().replace(" ", "_") + ".png")

