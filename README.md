# 🧠 CntxtCS: Minify Your C# Codebase Context for LLMs

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

> 🤯 **75% Token Reduction In LLM Context Window Usage!** 

## Why CntxtCS?

-  Boosts precision: Maps relationships and dependencies for clear analysis.
-  Eliminates noise: Focuses LLMs on key code insights.
-  Supports analysis: Reveals architecture for smarter LLM insights.
-  Speeds solutions: Helps LLMs trace workflows and logic faster.
-  Improves recommendations: Gives LLMs detailed metadata for better suggestions.
-  Optimized prompts: Provides structured context for better LLM responses.
-  Streamlines collaboration: Helps LLMs explain and document code easily.

Supercharge your LLM's understanding of your C# codebases. CntxtCS generates comprehensive knowledge graphs that help LLMs navigate and comprehend your code structure with ease.

It's like handing your LLM the cliff notes instead of a novel.

## **Active Enhancement Notice**

- CntxtCS is **actively being enhanced at high velocity with improvements every day**. Thank you for your contributions! 🙌

## ✨ Features

- 🔍 Deep analysis of C# codebases
- 📊 Generates detailed knowledge graphs of:
  - File relationships and dependencies
  - Class hierarchies and methods
  - Method signatures and parameters
  - Namespace structures
  - Using statements and references
  - NuGet package dependencies
  - Attributes and interfaces
- 🎯 Specially designed for LLM context windows
- 📈 Built-in visualization capabilities of your project's knowledge graph
- 🚀 Support for modern .NET frameworks and patterns

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/brandondocusen/CntxtCS.git

# Navigate to the directory
cd CntxtCS

# Run the Python file
python CntxtCS.py
```

When prompted, enter the path to your C# solution or project file. The tool will generate a `csharp_code_knowledge_graph.json` file and offer to visualize the relationships.

## 💡 Example Usage with LLMs

The LLM can now provide detailed insights about your codebase's implementations, understanding the relationships between components, classes, and namespaces! After generating your knowledge graph, you can upload it as a single file to give LLMs deep context about your codebase. Here's a powerful example prompt:

```Prompt Example
Based on the knowledge graph, explain how the service layer is implemented in this application, including which classes and methods are involved in the process.
```

```Prompt Example
Based on the knowledge graph, map out the core namespace structure - starting from the main application through to the different modules and their interactions.
```

```Prompt Example
Using the knowledge graph, analyze the dependency injection approach in this application. Which services exist, what do they manage, and how do they interact with components?
```

```Prompt Example
From the knowledge graph data, break down this application's controller hierarchy, focusing on API endpoints and their implementation patterns.
```

```Prompt Example
According to the knowledge graph, identify all exception handling patterns in this codebase - where are exceptions caught, how are they processed, and how are they handled?
```

```Prompt Example
Based on the knowledge graph's dependency analysis, outline the key NuGet packages this project relies on and their primary use cases in the application.
```

```Prompt Example
Using the knowledge graph's method analysis, explain how the application handles Entity Framework Core interactions and transaction patterns across different services.
```

## 📊 Output Format

The tool generates two main outputs:
1. A JSON knowledge graph (`csharp_code_knowledge_graph.json`)
2. Optional visualization using GraphViz

The knowledge graph includes:
- Detailed metadata about your codebase
- Node and edge relationships
- Method parameters and return types
- Class hierarchies
- Using statement mappings
- Namespace structures

## 🤝 Contributing

We love contributions! Whether it's:
- 🐛 Bug fixes
- ✨ New features
- 📚 Documentation improvements
- 🎨 Visualization enhancements

Just fork, make your changes, and submit a PR. Check out our [contribution guidelines](CONTRIBUTING.md) for more details.

## 🎯 Future Goals

- [ ] Deeper support for additional frameworks
- [ ] Enhanced attribute processing
- [ ] Interactive web-based visualizations
- [ ] Custom graph export formats
- [ ] Integration with Visual Studio and Rider
- [ ] Support for file-scoped namespaces and global using statements

## 📝 License

MIT License - feel free to use this in your own projects!

## 🌟 Show Your Support

If you find CntxtCS helpful, give it a star! ⭐️ 

---

Made with ❤️ for the LLM and .NET communities
