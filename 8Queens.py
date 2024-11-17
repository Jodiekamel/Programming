import random


def create_area():
    return [random.randint(0, 7) for _ in range(8)]  # Create a random area configuration.


def fitness(area):
    conflicts = 0
    for i in range(len(area)):
        for j in range(i + 1, len(area)):
            if area[i] == area[j] or abs(i - j) == abs(area[i] - area[j]):
                conflicts += 1
    return conflicts  # Evaluate the fitness of a given area configuration.


def crossover(parent1, parent2):
    crossover_point = random.randint(1, len(parent1) - 1)
    child1 = parent1[:crossover_point] + parent2[crossover_point:]
    child2 = parent2[:crossover_point] + parent1[crossover_point:]
    return child1, child2  # Perform crossover between two parent area configurations.


def mutate(area):
    index = random.randint(0, 7)
    area[index] = random.randint(0, 7)
    return area  # Mutate an area configuration by changing the value of a random queen's position.


def Eight_queens(population_size, generations):
    population = [create_area() for _ in range(population_size)]
    for _ in range(generations):
        population = sorted(population, key=lambda x: fitness(x))
        if fitness(population[0]) == 0:
            return population[0]  # If a solution is found, return it.
        new_population = []
        for _ in range(population_size // 2):
            parent1, parent2 = random.choices(population[:population_size // 2], k=2)
            child1, child2 = crossover(parent1, parent2)
            new_population.extend([mutate(child1), mutate(child2)])
        population = new_population


print(Eight_queens(100, 1000))