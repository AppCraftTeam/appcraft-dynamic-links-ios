import Firebase

public struct ACDynamicLink: Generator, Reader {
    
    // MARK: - Methods
    public func generate(path: NavigatablePath, isShort: Bool, completion: @escaping (URL?) -> Void) {
        generator.generate(path: path, isShort: isShort, completion: completion)
    }
    
    public func readFromURL(_ url: URL, completion: (NavigatablePath?) -> Void) -> Bool {
        reader.readFromURL(url, completion: completion)
    }
    
    public func readFromUserActivity(_ activity: NSUserActivity, completion: @escaping PathCompletionHandler) -> Bool {
        reader.readFromUserActivity(activity, completion: completion)
    }
    
    // MARK: - Init
    public init(generationData: GenerationDataProvider) {
        self.generator = FBGenerator(data: generationData)
        self.reader = FBReader()
    }
    
    // MARK: - Private Props
    private var generator: Generator
    private var reader: Reader
}
