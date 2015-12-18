enum ReturnType<T> {

    case Early(T)
    case Normal(T)

    case EarlyIfTrue(Bool, T)

    /// Transforms the current value into either .Normal(T) or .Early(T)
    func slim() -> ReturnType<T> {
        switch self {
        case .EarlyIfTrue(let isEarly, let res):
            if isEarly {
                return Early(res)
            }
            return Normal(res)
        default:
            return self
        }
    }
}

extension SequenceType {
    func earlyReduce<T>(initial: T, combine: (T, Self.Generator.Element) -> ReturnType<T>) -> T {

        var result = initial
        for el in self {
            switch combine(result, el).slim() {

            case .Early(let res):
                return res

            case .Normal(let res):
                result = res

             // will never match if slim() is called
            default: fatalError()

            }
        }
        return result
    }
}
