import Foundation

@inlinable
@discardableResult
func execute<A, Result>(
    _ transform: (A) throws -> Result,
    with a: A?) rethrows -> Result? {
    
    guard let a = a else { return nil }
    
    return try transform(a)
}

@inlinable
@discardableResult
func execute<A, B, Result>(
    _ transform: (A, B) throws -> Result,
    with a: A?,
    _ b: B?) rethrows -> Result? {
    
    guard
        let a = a,
        let b = b
        else {
            return nil
    }
    
    return try transform(a, b)
}

@inlinable
@discardableResult
func execute<A, B, C, Result>(
    _ transform: (A, B, C) throws -> Result,
    with a: A?,
    _ b: B?,
    _ c: C?) rethrows -> Result? {
    
    guard
        let a = a,
        let b = b,
        let c = c
        else {
            return nil
    }
    
    return try transform(a, b, c)
}

@inlinable
@discardableResult
func execute<A, B, C, D, Result>(
    _ transform: (A, B, C, D) throws -> Result,
    with a: A?,
    _ b: B?,
    _ c: C?,
    _ d: D?) rethrows -> Result? {
    
    guard
        let a = a,
        let b = b,
        let c = c,
        let d = d
        else {
            return nil
    }
    
    return try transform(a, b, c, d)
}

@inlinable
@discardableResult
func execute<A, B, C, D, E, Result>(
    _ transform: (A, B, C, D, E) throws -> Result,
    with a: A?,
    _ b: B?,
    _ c: C?,
    _ d: D?,
    _ e: E?) rethrows -> Result? {
    
    guard
        let a = a,
        let b = b,
        let c = c,
        let d = d,
        let e = e
        else {
            return nil
    }
    
    return try transform(a, b, c, d, e)
}

@inlinable
@discardableResult
func execute<A, B, C, D, E, F, Result>(
    _ transform: (A, B, C, D, E, F) throws -> Result,
    with a: A?,
    _ b: B?,
    _ c: C?,
    _ d: D?,
    _ e: E?,
    _ f: F?) rethrows -> Result? {
    
    guard
        let a = a,
        let b = b,
        let c = c,
        let d = d,
        let e = e,
        let f = f
        else {
            return nil
    }
    
    return try transform(a, b, c, d, e, f)
}
