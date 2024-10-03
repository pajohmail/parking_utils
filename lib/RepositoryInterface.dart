abstract class RepositoryInterface<T> {
 void add(T item);
 List<T> getAll();
 T getById(int id);
 void update(T item);
 void delete(T item);
}